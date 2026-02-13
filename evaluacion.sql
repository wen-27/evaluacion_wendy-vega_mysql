-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`tipo medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo medico` (
  `idtipo` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`medicos` (
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `cedula` BIGINT NOT NULL,
  `id_medico` VARCHAR(45) NOT NULL,
  `tipo medico_idtipo` INT NOT NULL,
  PRIMARY KEY (`id_medico`, `tipo medico_idtipo`),
  INDEX `fk_medicos_tipo medico1_idx` (`tipo medico_idtipo` ASC) VISIBLE,
  CONSTRAINT `fk_medicos_tipo medico1`
    FOREIGN KEY (`tipo medico_idtipo`)
    REFERENCES `mydb`.`tipo medico` (`idtipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cargo` (
  `idcargo` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleados` (
  `idempleados` INT NOT NULL,
  `nombre_empleado` VARCHAR(45) NOT NULL,
  `apellido_empleado` VARCHAR(45) NOT NULL,
  `cedula` BIGINT NOT NULL,
  `cargo_idcargo` INT NOT NULL,
  PRIMARY KEY (`idempleados`, `cargo_idcargo`),
  INDEX `fk_empleados_cargo1_idx` (`cargo_idcargo` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_cargo1`
    FOREIGN KEY (`cargo_idcargo`)
    REFERENCES `mydb`.`cargo` (`idcargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pacientes` (
  `idpacientes` INT NOT NULL,
  ` nombre_paciente` VARCHAR(45) NOT NULL,
  `apellico_paciente` VARCHAR(45) NOT NULL,
  `cedula_paciente` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpacientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sustitutos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sustitutos` (
  `idsustitutos` INT NOT NULL,
  `nombre_sustituto` VARCHAR(45) NOT NULL,
  `apellido_sustituto` VARCHAR(45) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_final` datetime NOT NULL,
  `medicos_id_medico` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idsustitutos`, `medicos_id_medico`),
  INDEX `fk_sustitutos_medicos1_idx` (`medicos_id_medico` ASC) VISIBLE,
  CONSTRAINT `fk_sustitutos_medicos1`
    FOREIGN KEY (`medicos_id_medico`)
    REFERENCES `mydb`.`medicos` (`id_medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo vacacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo vacacion` (
  `idtipo vacacion` INT NOT NULL,
  `tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`idtipo vacacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vacaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vacaciones` (
  `idvacaciones` INT NOT NULL,
  `empleados_idempleados` INT NOT NULL,
  `tipo vacacion_idtipo vacacion` INT NOT NULL,
  `medicos_id_medico` VARCHAR(45) NOT NULL,
  `fecha_inicio` date not null,
  `fecha_final`date not null,
  PRIMARY KEY (`idvacaciones`, `empleados_idempleados`, `tipo vacacion_idtipo vacacion`, `medicos_id_medico`),
  INDEX `fk_vacaciones_empleados1_idx` (`empleados_idempleados` ASC) VISIBLE,
  INDEX `fk_vacaciones_tipo vacacion1_idx` (`tipo vacacion_idtipo vacacion` ASC) VISIBLE,
  INDEX `fk_vacaciones_medicos1_idx` (`medicos_id_medico` ASC) VISIBLE,
  CONSTRAINT `fk_vacaciones_empleados1`
    FOREIGN KEY (`empleados_idempleados`)
    REFERENCES `mydb`.`empleados` (`idempleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vacaciones_tipo vacacion1`
    FOREIGN KEY (`tipo vacacion_idtipo vacacion`)
    REFERENCES `mydb`.`tipo vacacion` (`idtipo vacacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vacaciones_medicos1`
    FOREIGN KEY (`medicos_id_medico`)
    REFERENCES `mydb`.`medicos` (`id_medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`horario_medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`horario_medico` (
  `dia` INT NOT NULL,
  `hora_inicio` datetime NOT NULL,
  `hora_fin` datetime NOT NULL,
  `medicos_id_medico` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dia`, `medicos_id_medico`),
  INDEX `fk_horario_medico_medicos1_idx` (`medicos_id_medico` ASC) VISIBLE,
  CONSTRAINT `fk_horario_medico_medicos1`
    FOREIGN KEY (`medicos_id_medico`)
    REFERENCES `mydb`.`medicos` (`id_medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cita` (
  `idcita` INT NOT NULL,
  `hora_inicio` datetime NOT NULL,
  `hora_fin` datetime NOT NULL,
  `horario_medico_dia` INT NOT NULL,
  `horario_medico_medicos_id_medico` VARCHAR(45) NOT NULL,
  `pacientes_idpacientes` INT NOT NULL,
  PRIMARY KEY (`idcita`, `horario_medico_dia`, `horario_medico_medicos_id_medico`, `pacientes_idpacientes`),
  INDEX `fk_cita_horario_medico1_idx` (`horario_medico_dia` ASC, `horario_medico_medicos_id_medico` ASC) VISIBLE,
  INDEX `fk_cita_pacientes1_idx` (`pacientes_idpacientes` ASC) VISIBLE,
  CONSTRAINT `fk_cita_horario_medico1`
    FOREIGN KEY (`horario_medico_dia` , `horario_medico_medicos_id_medico`)
    REFERENCES `mydb`.`horario_medico` (`dia` , `medicos_id_medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cita_pacientes1`
    FOREIGN KEY (`pacientes_idpacientes`)
    REFERENCES `mydb`.`pacientes` (`idpacientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
