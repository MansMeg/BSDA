# Run from lectures/L6 to regenerate the normal-target energy diagram.
pdf("figs/hmc_normal_energy.pdf", width = 4.5, height = 4.5,
    family = "Helvetica", useDingbats = FALSE)
par(mar = c(3.4, 3.4, 0.5, 0.5), mgp = c(2, 0.6, 0), las = 1)
plot(NA, xlim = c(-1.9, 1.9), ylim = c(-1.9, 1.9), asp = 1,
     xlab = expression(theta), ylab = expression(psi), bty = "n",
     cex.lab = 1.3, cex.axis = 1.1)
abline(h = 0, v = 0, col = "grey85")
angle <- seq(0, 2*pi, length.out = 401)
r1 <- sqrt(1^2 + 0.5^2)
r2 <- sqrt(1^2 + 1.4^2)
lines(r1*cos(angle), r1*sin(angle), col = "#267A98", lwd = 2.5)
lines(r2*cos(angle), r2*sin(angle), col = "grey55", lwd = 2, lty = 2)
for (a in c(2.5, 4.5)) {
  arrows(r1*cos(a), r1*sin(a), r1*cos(a-0.2), r1*sin(a-0.2),
         length = 0.1, angle = 25, col = "#267A98", lwd = 2)
}
arrows(1, 0.5, 1, 1.35, length = 0.12, angle = 25,
       col = "#B00000", lwd = 2.5)
points(1, 0.5, pch = 19, col = "#267A98", cex = 1.2)
points(1, 1.4, pch = 19, col = "#B00000", cex = 1.2)
dev.off()
