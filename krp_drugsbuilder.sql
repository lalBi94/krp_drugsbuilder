/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Loadded par Zod#8682
CREATE TABLE IF NOT EXISTS `krp_drugsbuilder` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT 'NULL',
  `nametreat` varchar(50) DEFAULT 'NULL',
  `labeltreat` varchar(50) DEFAULT NULL,
  `prix` int(11) NOT NULL,
  `xR` float NOT NULL,
  `yR` float NOT NULL,
  `zR` float NOT NULL,
  `xT` float NOT NULL,
  `yT` float NOT NULL,
  `zT` float NOT NULL,
  `xV` float NOT NULL,
  `yV` float NOT NULL,
  `zV` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
