-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.6.17 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para svdb
CREATE DATABASE IF NOT EXISTS `svdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci */;
USE `svdb`;

-- Volcando estructura para tabla svdb.candidato
CREATE TABLE IF NOT EXISTS `candidato` (
  `id_candidato` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `apellido` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `id_votacion` int(11) NOT NULL,
  PRIMARY KEY (`id_candidato`),
  KEY `id_votacion` (`id_votacion`),
  CONSTRAINT `candidato_ibfk_1` FOREIGN KEY (`id_votacion`) REFERENCES `votacion` (`id_votacion`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla svdb.candidato: ~6 rows (aproximadamente)
DELETE FROM `candidato`;
INSERT INTO `candidato` (`id_candidato`, `nombre`, `apellido`, `id_votacion`) VALUES
	(1, 'Candidato', '101', 1),
	(2, 'Candidato', '102', 1),
	(3, 'Candidato', '203', 2),
	(4, 'Candidato', '204', 2),
	(5, 'Candidato', '305', 3),
	(6, 'Candidato', '306', 3);

-- Volcando estructura para procedimiento svdb.Resultado
DELIMITER //
CREATE PROCEDURE `Resultado`()
SELECT nombre, apellido, COUNT(*) AS votos
FROM voto INNER JOIN candidato ON voto.id_candidato = candidato.id_candidato
GROUP BY nombre, apellido//
DELIMITER ;

-- Volcando estructura para tabla svdb.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `apellido` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `contrasena` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `rol` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla svdb.usuario: ~5 rows (aproximadamente)
DELETE FROM `usuario`;
INSERT INTO `usuario` (`id_usuario`, `nombre`, `apellido`, `email`, `contrasena`, `rol`) VALUES
	(1, 'Roberto', 'Gomez', 'rgomez@gmail.com', '1234', 'votante'),
	(2, 'Carlos', 'Martinez', 'cmartinez@gmail.com', '1234', 'votante'),
	(3, 'Karla', 'Canata', 'kcanata@gmail.com', '1234', 'votante'),
	(4, 'Maria', 'Perez', 'mperez@gmail.com', '1234', 'votante'),
	(5, 'Nicolas', 'Garcia', 'ngarcia@gmail.com', '1234', 'admin');

-- Volcando estructura para tabla svdb.votacion
CREATE TABLE IF NOT EXISTS `votacion` (
  `id_votacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_votacion` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_votacion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla svdb.votacion: ~3 rows (aproximadamente)
DELETE FROM `votacion`;
INSERT INTO `votacion` (`id_votacion`, `nombre_votacion`, `fecha_inicio`, `fecha_fin`, `estado`) VALUES
	(1, 'Eleccion Centro de Estudiantes', '2024-10-01 00:00:00', '2024-10-31 00:00:00', 'ACTIVO'),
	(2, 'Proyecto Publicidad', '2024-11-01 00:00:00', '2024-11-10 00:00:00', 'CERRADO'),
	(3, 'Toma de decisiones', '2024-11-20 00:00:00', '2024-11-25 00:00:00', 'CERRADO');

-- Volcando estructura para tabla svdb.voto
CREATE TABLE IF NOT EXISTS `voto` (
  `id_voto` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_candidato` int(11) NOT NULL,
  `id_votacion` int(11) NOT NULL,
  `fecha_voto` datetime NOT NULL,
  PRIMARY KEY (`id_voto`),
  UNIQUE KEY `id_usuario_id_votacion` (`id_usuario`,`id_votacion`),
  KEY `id_candidato` (`id_candidato`),
  KEY `id_votacion` (`id_votacion`),
  CONSTRAINT `voto_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `voto_ibfk_2` FOREIGN KEY (`id_candidato`) REFERENCES `candidato` (`id_candidato`),
  CONSTRAINT `voto_ibfk_3` FOREIGN KEY (`id_votacion`) REFERENCES `votacion` (`id_votacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla svdb.voto: ~4 rows (aproximadamente)
DELETE FROM `voto`;
INSERT INTO `voto` (`id_voto`, `id_usuario`, `id_candidato`, `id_votacion`, `fecha_voto`) VALUES
	(1, 1, 1, 1, '2024-10-01 00:00:00'),
	(2, 2, 1, 1, '2024-10-01 00:00:00'),
	(3, 3, 1, 1, '2024-10-01 00:00:00'),
	(4, 4, 2, 1, '2024-10-01 00:00:00');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
