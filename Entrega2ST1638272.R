# Carreguem les llibreries necessàries
library(forecast)
library(TSA)
library(tscount)
library(tseries)
library(lmtest)
library(readr)
library(ggplot2)
library(zoo)
library(fGarch)

# Preparem les dades per realitzar la pràctica
dades <- read.table('datos.csv',
                    header = TRUE,
                    stringsAsFactors = TRUE,
                    sep = ';',
                    na.strings = 'NA',
                    dec = ',',
                    strip.white = TRUE,
                    fileEncoding = 'ISO-8859-1'
)

dades$Total <- as.numeric(gsub("\\.", "", as.character(dades$Total)))
dades <- dades[order(dades$Periodo), ] # Ordenem les dades
dades <- dades[, c('Periodo', 'Total')] # Ens quedem amb les dades que ens interessen

# Apartat a
dades <- dades[!(grepl('53', dades$Periodo)), ]
dades$Any <- c(rep(2000:2023, each = 52), rep(2024, times = 48))
Total <- ts(dades$Total[dades$Any %in% c(2010:2023)], start = c(2010, 1), end = c(2023, 52), frequency = 52)
mitjana_mobil <- rollmean(Total, k = 52, fill = NA)
mitjana_global <- mean(Total, na.rm = TRUE)
par(mfrow = c(1, 2), mar = c(2, 2, 4, 2))
ts.plot(Total, ylim = c(300, 1500), col = 'magenta')
abline(h = mitjana_global, col = 'blue')
lines(mitjana_mobil, col = 'springgreen')
legend('topleft', legend = c('Sèrie', 'Mitjana global', 'Mitjana mòbil (52)'), col = c('magenta', 'blue', 'springgreen'), lty = c(1, 1), bty = "n", cex = 0.5)
ts.plot(Total, xlim = c(2019, 2022), col = 'magenta')
abline(h = mitjana_global, col = 'blue')
lines(mitjana_mobil, col = 'springgreen')
legend('topright', legend = c('Sèrie', 'Mitjana global', 'Mitjana mòbil (52)'), col = c('magenta', 'blue', 'springgreen'), lty = c(1, 1), bty = "n", cex = 0.5)

# Apartat b
plot(decompose(Total)$trend)
coeftest(lm(Total ~ seq_along(Total)))

# Apartat c
# Eliminem NA de Total abans de graficar
Total_clean <- na.omit(Total)
ggseasonplot(Total_clean, ylim = c(500, 2000))

# Apartat d
# Assegurem que Total i dades$COVID tinguin la mateixa longitud
dades$COVID <- ifelse(dades$Any %in% c(2020, 2021), 1, 0)
valid_idx <- complete.cases(dades$Total, dades$COVID)
model_regression <- lm(as.numeric(dades$Total[valid_idx]) ~ dades$COVID[valid_idx])
summary(model_regression)

# Apartat e
diff1 <- diff(Total)
Total_diff1_52 <- diff(diff1, lag = 52)
mitjana_mobil_dif <- rollmean(Total_diff1_52, k = 52, fill = NA)
mitjana_global_dif <- mean(Total_diff1_52, na.rm = TRUE)
par(mfrow = c(1, 2), mar = c(2, 2, 4, 2))
ts.plot(Total_diff1_52, ylim = c(-500, 500), col = 'magenta')
abline(h = mitjana_global_dif, col = 'blue')
lines(mitjana_mobil_dif, col = 'springgreen')
legend('bottomleft', legend = c('Sèrie', 'Mitjana global', 'Mitjana mòbil (52)'), col = c('magenta', 'blue', 'springgreen'), lty = c(1, 1), bty = "n", cex = 0.3)
ts.plot(Total_diff1_52, xlim = c(2019, 2022), col = 'magenta')
abline(h = mitjana_global_dif, col = 'blue')
lines(mitjana_mobil_dif, col = 'springgreen')
legend('bottomleft', legend = c('Sèrie', 'Mitjana global', 'Mitjana mòbil (52)'), col = c('magenta', 'blue', 'springgreen'), lty = c(1, 1), bty = "n", cex = 0.3)

# Apartat f
ggseasonplot(Total_diff1_52)

# Apartat g
adf.test(Total_diff1_52)

# Apartat h
acf(Total_diff1_52, main = 'ACF de Total_diff1_52')
pacf(Total_diff1_52, main = 'PACF de Total_diff1_52')

# Apartat i
model.auto <- auto.arima(Total)
summary(model.auto)

# Apartat j
# Ajustem les dimensions de Total i dades$COVID per xreg
valid_idx <- complete.cases(dades$Total, dades$COVID)
xreg_covid <- matrix(dades$COVID[valid_idx], ncol = 1)
model_covid <- auto.arima(dades$Total[valid_idx], xreg = xreg_covid)
summary(model_covid)

# Apartat k
prediccio_2024 <- forecast(model.auto, h = 52)
real_2024 <- ts(dades$Total[dades$Any == 2024], start = c(2024, 1), frequency = 52)
plot(prediccio_2024, main = "Predicció de Defuncions per 2024 amb Model ARIMA", xlab = "Setmana", ylab = "Nombre de Defuncions", col = "blue", lwd = 2)
lines(real_2024, col = "red", lwd = 2)
legend("topright", legend = c("Predicció", "Valor Real"), col = c("blue", "red"), lwd = 2)

# Apartat l
acf(residuals(model.auto), main = 'Residus del Model ARIMA')
acf(residuals(model.auto)^2, main = 'Quadrat dels Residus del Model ARIMA')
Box.test(residuals(model.auto), type = 'Ljung-Box')
Box.test(residuals(model.auto)^2, type = 'Ljung-Box')

# Apartat m
model_garch_10 <- garchFit(~ garch(1, 0), data = Total_diff1_52, trace = FALSE)
model_garch_11 <- garchFit(~ garch(1, 1), data = Total_diff1_52, trace = FALSE)
model_garch_21 <- garchFit(~ garch(2, 1), data = Total_diff1_52, trace = FALSE)
cat("L'AIC per al model GARCH(1,0) és", model_garch_10@fit$ics["AIC"], "\n")
cat("L'AIC per al model GARCH(1,1) és", model_garch_11@fit$ics["AIC"], "\n")
cat("L'AIC per al model GARCH(2,1) és", model_garch_21@fit$ics["AIC"], "\n")

# Apartat n
acf(residuals(model_garch_11), main = "ACF dels Residus del Model GARCH(1,1)")
acf(residuals(model_garch_11)^2, main = "ACF dels Residus al Quadrat del Model GARCH(1,1)")
sum_residuals <- summary(model_garch_11)
sum_residuals

