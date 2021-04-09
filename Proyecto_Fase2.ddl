-- Generado por Oracle SQL Developer Data Modeler 20.3.0.283.0710
--   en:        2021-03-29 16:08:04 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE asignacion (
    año      VARCHAR2(4 CHAR) NOT NULL,
    seccion  VARCHAR2(2 CHAR) NOT NULL,
    ciclo    VARCHAR2(50 CHAR) NOT NULL,
    codigo   INTEGER NOT NULL,
    carnet   INTEGER NOT NULL,
    zona     INTEGER NOT NULL,
    nota     INTEGER NOT NULL
);

ALTER TABLE asignacion
    ADD CONSTRAINT asignacion_pk PRIMARY KEY ( año,
                                               seccion,
                                               ciclo,
                                               codigo,
                                               carnet );

CREATE TABLE carrera (
    carrera  INTEGER NOT NULL,
    nombre   VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE carrera ADD CONSTRAINT carrera_pk PRIMARY KEY ( carrera );

CREATE TABLE catedratico (
    cat            INTEGER NOT NULL,
    nombre         VARCHAR2(50 CHAR) NOT NULL,
    sueldomensual  NUMBER NOT NULL
);

ALTER TABLE catedratico ADD CONSTRAINT catedratico_pk PRIMARY KEY ( cat );

CREATE TABLE curso (
    codigo  INTEGER NOT NULL,
    nombre  VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY ( codigo );

CREATE TABLE dia (
    dia     INTEGER NOT NULL,
    nombre  VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE dia ADD CONSTRAINT dia_pk PRIMARY KEY ( dia );

CREATE TABLE estudiante (
    carnet           INTEGER NOT NULL,
    nombre           VARCHAR2(50 CHAR) NOT NULL,
    ingresofamiliar  NUMBER NOT NULL,
    fechanacimiento  DATE
);

ALTER TABLE estudiante ADD CONSTRAINT estudiante_pk PRIMARY KEY ( carnet );

CREATE TABLE horario (
    dia       INTEGER NOT NULL,
    periodo   INTEGER NOT NULL,
    año       VARCHAR2(4 CHAR) NOT NULL,
    seccion   VARCHAR2(2 CHAR) NOT NULL,
    ciclo     VARCHAR2(50 CHAR) NOT NULL,
    codcurso  INTEGER NOT NULL,
    edificio  VARCHAR2(10 CHAR) NOT NULL,
    salon     VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE horario
    ADD CONSTRAINT horario_pk PRIMARY KEY ( dia,
                                            periodo,
                                            año,
                                            seccion,
                                            ciclo,
                                            codcurso );

CREATE TABLE inscrito (
    carnet            INTEGER NOT NULL,
    carrera           INTEGER NOT NULL,
    fechainscription  DATE NOT NULL
);

ALTER TABLE inscrito ADD CONSTRAINT inscrito_pk PRIMARY KEY ( carnet,
                                                              carrera );

CREATE TABLE pensum (
    obligatoriedad  CHAR(1 CHAR) NOT NULL,
    numcreditos     INTEGER NOT NULL,
    notaaprobacion  INTEGER NOT NULL,
    zonaminima      INTEGER NOT NULL,
    credprerreq     INTEGER NOT NULL,
    codcurso        INTEGER NOT NULL,
    plan            VARCHAR2(10 CHAR) NOT NULL,
    carrera         INTEGER NOT NULL
);

ALTER TABLE pensum
    ADD CONSTRAINT pensum_pk PRIMARY KEY ( codcurso,
                                           plan,
                                           carrera );

CREATE TABLE periodo (
    periodo     INTEGER NOT NULL,
    horainicio  DATE NOT NULL,
    horafinal   DATE NOT NULL
);

ALTER TABLE periodo ADD CONSTRAINT periodo_pk PRIMARY KEY ( periodo );

CREATE TABLE plan (
    plan               VARCHAR2(10 CHAR) NOT NULL,
    nombre             VARCHAR2(50 CHAR) NOT NULL,
    añoinicial         VARCHAR2(4 CHAR) NOT NULL,
    cicloinicial       VARCHAR2(50 CHAR) NOT NULL,
    añofinal           VARCHAR2(4 CHAR) NOT NULL,
    ciclofinal         VARCHAR2(50 CHAR) NOT NULL,
    numcreditoscierre  INTEGER NOT NULL,
    carrera            INTEGER NOT NULL
);

ALTER TABLE plan ADD CONSTRAINT plan_pk PRIMARY KEY ( plan,
                                                      carrera );

CREATE TABLE prerreq (
    codcurso    INTEGER NOT NULL,
    plan        VARCHAR2(10 CHAR) NOT NULL,
    carrera     INTEGER NOT NULL,
    codprerreq  INTEGER NOT NULL
);

ALTER TABLE prerreq
    ADD CONSTRAINT prerreq_pk PRIMARY KEY ( codcurso,
                                            plan,
                                            carrera,
                                            codprerreq );

CREATE TABLE salon (
    edificio   VARCHAR2(10 CHAR) NOT NULL,
    salon      VARCHAR2(10 CHAR) NOT NULL,
    capacidad  INTEGER NOT NULL
);

ALTER TABLE salon ADD CONSTRAINT salon_pk PRIMARY KEY ( edificio,
                                                        salon );

CREATE TABLE seccion (
    seccion         VARCHAR2(2 CHAR) NOT NULL,
    año             VARCHAR2(4 CHAR) NOT NULL,
    ciclo           VARCHAR2(50 CHAR) NOT NULL,
    codcatedratico  INTEGER NOT NULL,
    codcurso        INTEGER NOT NULL
);

ALTER TABLE seccion
    ADD CONSTRAINT seccion_pk PRIMARY KEY ( año,
                                            seccion,
                                            ciclo,
                                            codcurso );

ALTER TABLE asignacion
    ADD CONSTRAINT asignacion_estudiante_fk FOREIGN KEY ( carnet )
        REFERENCES estudiante ( carnet );

ALTER TABLE asignacion
    ADD CONSTRAINT asignacion_seccion_fk FOREIGN KEY ( año,
                                                       seccion,
                                                       ciclo,
                                                       codigo )
        REFERENCES seccion ( año,
                             seccion,
                             ciclo,
                             codcurso );

ALTER TABLE horario
    ADD CONSTRAINT horario_dia_fk FOREIGN KEY ( dia )
        REFERENCES dia ( dia );

ALTER TABLE horario
    ADD CONSTRAINT horario_periodo_fk FOREIGN KEY ( periodo )
        REFERENCES periodo ( periodo );

ALTER TABLE horario
    ADD CONSTRAINT horario_salon_fk FOREIGN KEY ( edificio,
                                                  salon )
        REFERENCES salon ( edificio,
                           salon );

ALTER TABLE horario
    ADD CONSTRAINT horario_seccion_fk FOREIGN KEY ( año,
                                                    seccion,
                                                    ciclo,
                                                    codcurso )
        REFERENCES seccion ( año,
                             seccion,
                             ciclo,
                             codcurso );

ALTER TABLE inscrito
    ADD CONSTRAINT inscrito_carrera_fk FOREIGN KEY ( carrera )
        REFERENCES carrera ( carrera );

ALTER TABLE inscrito
    ADD CONSTRAINT inscrito_estudiante_fk FOREIGN KEY ( carnet )
        REFERENCES estudiante ( carnet );

ALTER TABLE pensum
    ADD CONSTRAINT pensum_curso_fk FOREIGN KEY ( codcurso )
        REFERENCES curso ( codigo );

ALTER TABLE pensum
    ADD CONSTRAINT pensum_plan_fk FOREIGN KEY ( plan,
                                                carrera )
        REFERENCES plan ( plan,
                          carrera );

ALTER TABLE plan
    ADD CONSTRAINT plan_carrera_fk FOREIGN KEY ( carrera )
        REFERENCES carrera ( carrera );

ALTER TABLE prerreq
    ADD CONSTRAINT prerreq_curso_fk FOREIGN KEY ( codprerreq )
        REFERENCES curso ( codigo );

ALTER TABLE prerreq
    ADD CONSTRAINT prerreq_pensum_fk FOREIGN KEY ( codcurso,
                                                   plan,
                                                   carrera )
        REFERENCES pensum ( codcurso,
                            plan,
                            carrera );

ALTER TABLE seccion
    ADD CONSTRAINT seccion_catedratico_fk FOREIGN KEY ( codcatedratico )
        REFERENCES catedratico ( cat );

ALTER TABLE seccion
    ADD CONSTRAINT seccion_curso_fk FOREIGN KEY ( codcurso )
        REFERENCES curso ( codigo );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             0
-- ALTER TABLE                             29
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
