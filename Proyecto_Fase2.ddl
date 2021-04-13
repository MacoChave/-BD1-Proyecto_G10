CREATE TABLE carrera (
    carrera  INTEGER NOT NULL,
    nombre   VARCHAR2(50 CHAR) NOT NULL
);


ALTER TABLE carrera ADD CONSTRAINT carrera_pk PRIMARY KEY ( carrera );

CREATE TABLE estudiante (
    carnet           INTEGER NOT NULL,
    nombre           VARCHAR2(50 CHAR) NOT NULL,
    ingresofamiliar  NUMBER NOT NULL,
    fechanacimiento  DATE
);

ALTER TABLE estudiante ADD CONSTRAINT estudiante_pk PRIMARY KEY ( carnet );

CREATE TABLE inscrito (
    carnet            INTEGER NOT NULL,
    carrera           INTEGER NOT NULL,
    fechainscription  DATE NOT NULL
);

ALTER TABLE inscrito ADD CONSTRAINT inscrito_pk PRIMARY KEY ( carnet,
                                                              carrera );

ALTER TABLE inscrito
    ADD CONSTRAINT inscrito_carrera_fk FOREIGN KEY ( carrera )
        REFERENCES carrera ( carrera );

ALTER TABLE inscrito
    ADD CONSTRAINT inscrito_estudiante_fk FOREIGN KEY ( carnet )
        REFERENCES estudiante ( carnet );

CREATE TABLE curso (
    codigo  INTEGER NOT NULL,
    nombre  VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY ( codigo );

CREATE TABLE plan (
 plan               VARCHAR2(10 CHAR) NOT NULL,
 nombre             VARCHAR2(50 CHAR) NOT NULL,
 yearinicial         VARCHAR2(4 CHAR) NOT NULL,
 cicloinicial       VARCHAR2(50 CHAR) NOT NULL,
 yearfinal           VARCHAR2(4 CHAR) NOT NULL,
 ciclofinal         VARCHAR2(50 CHAR) NOT NULL,
 numcreditoscierre  INTEGER NOT NULL,
 carrera            INTEGER NOT NULL
);

ALTER TABLE plan ADD CONSTRAINT plan_pk PRIMARY KEY ( plan,
                                                   carrera );

ALTER TABLE plan
 ADD CONSTRAINT plan_carrera_fk FOREIGN KEY ( carrera )
     REFERENCES carrera ( carrera );

-- TRIGGER A�O Y CICLO
CREATE OR REPLACE TRIGGER yearCiclo_trg
BEFORE INSERT ON plan
FOR EACH ROW
BEGIN
  UPDATE plan
  SET
    yearfinal = :new.yearinicial + 10,
    ciclofinal = :new.ciclofinal + 10
    WHERE plan = :new.plan;
END;

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

ALTER TABLE pensum
ADD CONSTRAINT pensum_curso_fk FOREIGN KEY ( codcurso )
    REFERENCES curso ( codigo );

ALTER TABLE pensum
ADD CONSTRAINT pensum_plan_fk FOREIGN KEY ( plan,
                                            carrera )
    REFERENCES plan ( plan,
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

CREATE TABLE periodo (
    periodo     INTEGER NOT NULL,
    horainicio  DATE NOT NULL,
    horafinal   DATE NOT NULL
);

ALTER TABLE periodo ADD CONSTRAINT periodo_pk PRIMARY KEY ( periodo );

-- TRIGGER AUTO INCREMENTO

CREATE TABLE dia (
    dia     INTEGER NOT NULL,
    nombre  VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE dia ADD CONSTRAINT dia_pk PRIMARY KEY ( dia );

CREATE TABLE salon (
    edificio   VARCHAR2(10 CHAR) NOT NULL,
    salon      VARCHAR2(10 CHAR) NOT NULL,
    capacidad  INTEGER NOT NULL
);

ALTER TABLE salon ADD CONSTRAINT salon_pk PRIMARY KEY ( edificio,
                                                        salon );

CREATE TABLE catedratico (
  cat            INTEGER NOT NULL,
  nombre         VARCHAR2(50 CHAR) NOT NULL,
  sueldomensual  NUMBER NOT NULL
);

ALTER TABLE catedratico ADD CONSTRAINT catedratico_pk PRIMARY KEY ( cat );

-- TRIGGER AUTO INCREMENTO

CREATE TABLE seccion (
    seccion         VARCHAR2(2 CHAR) NOT NULL,
    year             VARCHAR2(4 CHAR) NOT NULL,
    ciclo           VARCHAR2(50 CHAR) NOT NULL,
    codcatedratico  INTEGER NOT NULL,
    codcurso        INTEGER NOT NULL
);

ALTER TABLE seccion
    ADD CONSTRAINT seccion_pk PRIMARY KEY ( year,
                                            seccion,
                                            ciclo,
                                            codcurso );

ALTER TABLE seccion
    ADD CONSTRAINT seccion_catedratico_fk FOREIGN KEY ( codcatedratico )
        REFERENCES catedratico ( cat );

ALTER TABLE seccion
    ADD CONSTRAINT seccion_curso_fk FOREIGN KEY ( codcurso )
        REFERENCES curso ( codigo );

CREATE TABLE horario (
    dia       INTEGER NOT NULL,
    periodo   INTEGER NOT NULL,
    year       VARCHAR2(4 CHAR) NOT NULL,
    seccion   VARCHAR2(2 CHAR) NOT NULL,
    ciclo     VARCHAR2(50 CHAR) NOT NULL,
    codcurso  INTEGER NOT NULL,
    edificio  VARCHAR2(10 CHAR) NOT NULL,
    salon     VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE horario
    ADD CONSTRAINT horario_pk PRIMARY KEY ( dia,
                                            periodo,
                                            year,
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
ADD CONSTRAINT horario_seccion_fk FOREIGN KEY ( year,
  seccion,
  ciclo,
  codcurso )
  REFERENCES seccion ( year,
    seccion,
    ciclo,
    codcurso );

CREATE TABLE asignacion (
    year      VARCHAR2(4 CHAR) NOT NULL,
    seccion  VARCHAR2(2 CHAR) NOT NULL,
    ciclo    VARCHAR2(50 CHAR) NOT NULL,
    codigo   INTEGER NOT NULL,
    carnet   INTEGER NOT NULL,
    zona     INTEGER NOT NULL,
    nota     INTEGER NOT NULL
);

ALTER TABLE asignacion
    ADD CONSTRAINT asignacion_pk PRIMARY KEY ( year,
                                               seccion,
                                               ciclo,
                                               codigo,
                                               carnet );

ALTER TABLE asignacion
ADD CONSTRAINT asignacion_estudiante_fk FOREIGN KEY ( carnet )
REFERENCES estudiante ( carnet );

ALTER TABLE asignacion
ADD CONSTRAINT asignacion_seccion_fk FOREIGN KEY ( year,
 seccion,
 ciclo,
 codigo )
 REFERENCES seccion ( year,
   seccion,
   ciclo,
   codcurso );
