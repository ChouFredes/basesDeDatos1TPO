CREATE DATABASE TPO_Naruto
go

CREATE TABLE Aldea (
    NombreAldea VARCHAR(40) NOT NULL,
    HabitantesAldea INT NOT NULL,
    TerritorioAldea VARCHAR(50) NOT NULL,
    PosicionAldea VARCHAR(50)
	CONSTRAINT PK_NombreAldea_Aldea PRIMARY KEY(NombreAldea),
);

CREATE TABLE Edificio (
    NombreEdificio VARCHAR(30) NOT NULL,
    CapacidadNinjas INT NOT NULL,
    TipoEstructura VARCHAR(50) NOT NULL,
    NombreAldea VARCHAR(40) NOT NULL,
	CONSTRAINT PK_NombreEdificio_Edificio PRIMARY KEY(NombreEdificio),
    FOREIGN KEY (NombreAldea) REFERENCES Aldea(NombreAldea)
);

CREATE TABLE Conflicto (
    NombreConflicto VARCHAR(73) NOT NULL,
    FechaConflicto DATE,
    LugarConflicto VARCHAR(50) NOT NULL,
    BajasConflicto VARCHAR(20),
	CONSTRAINT PK_NombreConflicto_Conflicto PRIMARY KEY (NombreConflicto)
);

CREATE TABLE ClanConflicto (
    Id_Conflicto INT NOT NULL,
    NombreAldea VARCHAR(40) NOT NULL,
    NombreConflicto VARCHAR(73) NOT NULL,
	CONSTRAINT PK_AldeaConflicto PRIMARY KEY (Id_Conflicto),
	CONSTRAINT FK_NombreAldea_Aldea FOREIGN KEY (NombreAldea) REFERENCES Aldea(NombreAldea),
	CONSTRAINT FK_NombreConflicto FOREIGN KEY (NombreConflicto) REFERENCES Conflicto(NombreConflicto)
);


CREATE TABLE Clan (
    NombreClan VARCHAR(30) NOT NULL,
    AldeaOculta VARCHAR(40) NOT NULL,
    FundacionClan INT,
    LemaClan VARCHAR(80) NOT NULL,
    DescripcionEmblema VARCHAR(60),
    Particularidad VARCHAR(50),
	CONSTRAINT PK_NombreClan_Clan PRIMARY KEY (NombreClan),
	CONSTRAINT FK_AldeaOculta FOREIGN KEY (AldeaOculta) REFERENCES Aldea(NombreAldea)
);

CREATE TABLE Equipo (
    NombreEquipo VARCHAR(40) NOT NULL,
    FundacionEquipo INT,
    IntegrantesEquipo INT NOT NULL,
    EstadoEquipo VARCHAR(15) NOT NULL,
	CONSTRAINT PK_NombreEquipo_Equipo PRIMARY KEY (NombreEquipo)
);


CREATE TABLE Especie (
    NombreEspecie VARCHAR(30) NOT NULL,
    EstadoEspecie VARCHAR(20) NOT NULL,
    HostilidadEspecie VARCHAR(20),
    HabilidadEspecie VARCHAR(50) NOT NULL,
	CONSTRAINT PK_NombreEspecie_Especie PRIMARY KEY (NombreEspecie)
);

CREATE TABLE Shinobi (
    NombreShinobi VARCHAR(40)NOT NULL,
    NacimientoShinobi DATE NOT NULL,
    EstatusShinobi VARCHAR(15)NOT NULL,
    AldeaOculta VARCHAR(40) NOT NULL,
    NombreClan VARCHAR(30) NOT NULL,
    NombreEquipo VARCHAR(40) NOT NULL,
    NombreEspecie VARCHAR(30) NOT NULL,
	CONSTRAINT PK_Shinobi PRIMARY KEY (NombreShinobi, NacimientoShinobi),
	CONSTRAINT FK_AldeaOculta_Shinobi FOREIGN KEY (AldeaOculta) REFERENCES Aldea(NombreAldea),
    CONSTRAINT FK_NombreClan_Shinobi FOREIGN KEY (NombreClan) REFERENCES Clan(NombreClan),
	CONSTRAINT FK_NombreEquipo_Shinobi FOREIGN KEY (NombreEquipo) REFERENCES Equipo(NombreEquipo),
	CONSTRAINT FK_TipoLinaje_Shinobi FOREIGN KEY (TipoLinaje) REFERENCES TipoLinaje(TipoLinaje),
	CONSTRAINT FK_NombreEspecie_Shinobi FOREIGN KEY (NombreEspecie) REFERENCES Especie(NombreEspecie)
);


CREATE TABLE Habilidad (
    NombreHabilidad VARCHAR(30) NOT NULL,
    MaestroHabilidad VARCHAR(40),
    TipoHabilidad VARCHAR(20) NOT NULL,
	CONSTRAINT PK_NombreHabilidad_Habilidad PRIMARY KEY (NombreHabilidad)
);

CREATE TABLE ShinobiHabilidad (
    Id_Habilidad INT NOT NULL,
    NombreShinobi VARCHAR(40) NOT NULL,
    NacimientoShinobi DATE NOT NULL,
    NombreHabilidad VARCHAR(30) NOT NULL,
	CONSTRAINT PK_IdHabilidad_ShinobiHabilidad PRIMARY KEY (Id_Habilidad),
	CONSTRAINT FK_ShinobiHabilidad_Shinobi FOREIGN KEY (NombreShinobi, NacimientoShinobi) REFERENCES Shinobi(NombreShinobi, NacimientoShinobi),
    CONSTRAINT FK_ShinobiHabilidad_Habilidad FOREIGN KEY (NombreHabilidad) REFERENCES Habilidad(NombreHabilidad)
);

CREATE TABLE RelacionFamiliar (
    Id_Relacion INT IDENTITY NOT NULL,
    NombreShinobi1 VARCHAR(40) NOT NULL,
    NacimientoShinobi1 DATE NOT NULL,
    NombreShinobi2 VARCHAR(40) NOT NULL,
    NacimientoShinobi2 DATE NOT NULL,
    TipoRelacion VARCHAR(20) NOT NULL, 
	CONSTRAINT PK_RelacionFamiliar PRIMARY KEY (Id_Relacion),
    CONSTRAINT FK_NombreShinobi1_Shinobi FOREIGN KEY (NombreShinobi1, NacimientoShinobi1) REFERENCES Shinobi(NombreShinobi, NacimientoShinobi),
    CONSTRAINT FK_NombreShinobi2_Shinobi FOREIGN KEY (NombreShinobi2, NacimientoShinobi2) REFERENCES Shinobi(NombreShinobi, NacimientoShinobi)
);


CREATE PROCEDURE InsertarDatosEdificio
    @NombreEdificio VARCHAR(30),
    @CapacidadNinjas INT,
    @TipoEstructura VARCHAR(50),
    @NombreAldea VARCHAR(40)
AS
BEGIN
    INSERT INTO Edificio (NombreEdificio, CapacidadNinjas, TipoEstructura, NombreAldea)
    VALUES (@NombreEdificio, @CapacidadNinjas, @TipoEstructura, @NombreAldea)
END
GO

CREATE PROCEDURE BorrarDatosEdificio
(
    @NombreEdificio VARCHAR(30)
)
AS
BEGIN
    DELETE FROM Edificio
    WHERE
        NombreEdificio = @NombreEdificio
END
GO


CREATE PROCEDURE InsertarDatosAldea
    @NombreAldea VARCHAR(40),
    @HabitantesAldea INT,
    @TerritorioAldea VARCHAR(50),
    @PosicionAldea VARCHAR(50)
AS
BEGIN
    INSERT INTO Aldea (NombreAldea, HabitantesAldea, TerritorioAldea, PosicionAldea)
    VALUES (@NombreAldea, @HabitantesAldea, @TerritorioAldea, @PosicionAldea)
END
GO

CREATE PROCEDURE ActualizarDatosAldea
(
    @NombreAldea VARCHAR(40),
    @HabitantesAldea INT,
    @TerritorioAldea VARCHAR(50),
    @PosicionAldea VARCHAR(50)
)
AS
BEGIN
    UPDATE Aldea
    SET
        HabitantesAldea = @HabitantesAldea,
        TerritorioAldea = @TerritorioAldea,
        PosicionAldea = @PosicionAldea
    WHERE
        NombreAldea = @NombreAldea
END
GO


CREATE PROCEDURE InsertarDatosClan
(
    @NombreClan VARCHAR(30),
    @AldeaOculta VARCHAR(40),
    @FundacionClan INT,
    @LemaClan VARCHAR(80),
    @DescripcionEmblema VARCHAR(60),
    @Particularidad VARCHAR(50)
)
AS
BEGIN
    INSERT INTO Clan (NombreClan, AldeaOculta, FundacionClan, LemaClan, DescripcionEmblema, Particularidad)
    VALUES (@NombreClan, @AldeaOculta, @FundacionClan, @LemaClan, @DescripcionEmblema, @Particularidad)
END
GO

CREATE PROCEDURE ActualizarDatosClan
(
    @NombreClan VARCHAR(30),
    @AldeaOculta VARCHAR(40),
    @FundacionClan INT,
    @LemaClan VARCHAR(80),
    @DescripcionEmblema VARCHAR(60),
    @Particularidad VARCHAR(50)
)
AS
BEGIN
    UPDATE Clan
    SET
        AldeaOculta = @AldeaOculta,
        FundacionClan = @FundacionClan,
        LemaClan = @LemaClan,
        DescripcionEmblema = @DescripcionEmblema,
        Particularidad = @Particularidad
    WHERE
        NombreClan = @NombreClan
END
GO

CREATE PROCEDURE BorrarDatosClan
(
    @NombreClan VARCHAR(30)
)
AS
BEGIN
    DELETE FROM Clan
    WHERE
        NombreClan = @NombreClan
END
GO



CREATE PROCEDURE InsertarDatosConflicto
(
    @NombreConflicto VARCHAR(73),
    @FechaConflicto DATE,
    @LugarConflicto VARCHAR(50),
    @BajasConflicto VARCHAR(20)
)
AS
BEGIN
    INSERT INTO Conflicto (NombreConflicto, FechaConflicto, LugarConflicto, BajasConflicto)
    VALUES (@NombreConflicto, @FechaConflicto, @LugarConflicto, @BajasConflicto)
END
GO

CREATE PROCEDURE ActualizarDatosConflicto
(
    @NombreConflicto VARCHAR(73),
    @FechaConflicto DATE,
    @LugarConflicto VARCHAR(50),
    @BajasConflicto VARCHAR(20)
)
AS
BEGIN
    UPDATE Conflicto
    SET
        FechaConflicto = @FechaConflicto,
        LugarConflicto = @LugarConflicto,
        BajasConflicto = @BajasConflicto
    WHERE
        NombreConflicto = @NombreConflicto
END
GO

CREATE PROCEDURE BorrarDatosConflicto
(
    @NombreConflicto VARCHAR(73)
)
AS
BEGIN
    DELETE FROM Conflicto
    WHERE
        NombreConflicto = @NombreConflicto
END
GO


CREATE PROCEDURE InsertarDatosEspecie
(
    @NombreEspecie VARCHAR(30),
    @EstadoEspecie VARCHAR(20),
    @HostilidadEspecie VARCHAR(20),
    @HabilidadEspecie VARCHAR(50)
)
AS
BEGIN
    INSERT INTO Especie (NombreEspecie, EstadoEspecie, HostilidadEspecie, HabilidadEspecie)
    VALUES (@NombreEspecie, @EstadoEspecie, @HostilidadEspecie, @HabilidadEspecie)
END
GO

CREATE PROCEDURE ActualizarDatosEspecie
(
    @NombreEspecie VARCHAR(30),
    @EstadoEspecie VARCHAR(20),
    @HostilidadEspecie VARCHAR(20),
    @HabilidadEspecie VARCHAR(50)
)
AS
BEGIN
    UPDATE Especie
    SET
        EstadoEspecie = @EstadoEspecie,
        HostilidadEspecie = @HostilidadEspecie,
        HabilidadEspecie = @HabilidadEspecie
    WHERE
        NombreEspecie = @NombreEspecie
END
GO

CREATE PROCEDURE BorrarDatosEspecie
(
    @NombreEspecie VARCHAR(30)
)
AS
BEGIN
    DELETE FROM Especie
    WHERE
        NombreEspecie = @NombreEspecie
END
GO



CREATE PROCEDURE InsertarDatosShinobi
   (
   @NombreShinobi VARCHAR(40),
   @NacimientoShinobi DATE,
   @EstatusShinobi VARCHAR(15),
   @AldeaOculta VARCHAR(40),
   @NombreClan VARCHAR(30),
   @NombreEquipo VARCHAR(40),
   @NombreEspecie VARCHAR(30)
   )
AS
BEGIN
   INSERT INTO Shinobi(NombreShinobi, NacimientoShinobi, EstatusShinobi, AldeaOculta, NombreClan, NombreEquipo, NombreEspecie)
   VALUES (@NombreShinobi, @NacimientoShinobi, @EstatusShinobi, @AldeaOculta, @NombreClan, @NombreEquipo, @NombreEspecie);
END
GO

CREATE PROCEDURE ActualizarDatosShinobi
(
    @NombreShinobi VARCHAR(40),
    @NacimientoShinobi DATE,
    @EstatusShinobi VARCHAR(15),
    @AldeaOculta VARCHAR(40),
    @NombreClan VARCHAR(30),
    @NombreEquipo VARCHAR(40),
    @NombreEspecie VARCHAR(30)
)
AS
BEGIN
    UPDATE Shinobi
    SET
        NacimientoShinobi = @NacimientoShinobi,
        EstatusShinobi = @EstatusShinobi,
        AldeaOculta = @AldeaOculta,
        NombreClan = @NombreClan,
        NombreEquipo = @NombreEquipo,
        NombreEspecie = @NombreEspecie
    WHERE
        NombreShinobi = @NombreShinobi AND NacimientoShinobi = @NacimientoShinobi
END
GO

CREATE PROCEDURE BorrarDatosShinobi
(
    @NombreShinobi VARCHAR(40),
    @NacimientoShinobi DATE
)
AS
BEGIN
    DELETE FROM Shinobi
    WHERE
        NombreShinobi = @NombreShinobi AND NacimientoShinobi = @NacimientoShinobi
END
GO



drop procedure InsertarDatosShinobi

CREATE PROCEDURE InsertarHabilidad
(
    @NombreHabilidad VARCHAR(30),
    @MaestroHabilidad VARCHAR(40),
    @TipoHabilidad VARCHAR(20)
)
AS
BEGIN
    INSERT INTO Habilidad (NombreHabilidad, MaestroHabilidad, TipoHabilidad)
    VALUES (@NombreHabilidad, @MaestroHabilidad, @TipoHabilidad);
END
GO

CREATE PROCEDURE ActualizarDatosHabilidad
(
    @NombreHabilidad VARCHAR(30),
    @MaestroHabilidad VARCHAR(40),
    @TipoHabilidad VARCHAR(20)
)
AS
BEGIN
    UPDATE Habilidad
    SET
        MaestroHabilidad = @MaestroHabilidad,
        TipoHabilidad = @TipoHabilidad
    WHERE
        NombreHabilidad = @NombreHabilidad
END
GO

CREATE PROCEDURE BorrarDatosHabilidad
(
    @NombreHabilidad VARCHAR(30)
)
AS
BEGIN
    DELETE FROM Habilidad
    WHERE
        NombreHabilidad = @NombreHabilidad
END
GO


CREATE PROCEDURE InsertarDatosEquipo
(
    @NombreEquipo VARCHAR(40),
    @FundacionEquipo INT,
    @IntegrantesEquipo INT,
    @EstadoEquipo VARCHAR(15)
)
AS
BEGIN
    INSERT INTO Equipo (NombreEquipo, FundacionEquipo, IntegrantesEquipo, EstadoEquipo)
    VALUES (@NombreEquipo, @FundacionEquipo, @IntegrantesEquipo, @EstadoEquipo)
END
GO

CREATE PROCEDURE ActualizarDatosEquipo
(
    @NombreEquipo VARCHAR(40),
    @FundacionEquipo INT,
    @IntegrantesEquipo INT,
    @EstadoEquipo VARCHAR(15)
)
AS
BEGIN
    UPDATE Equipo
    SET
        FundacionEquipo = @FundacionEquipo,
        IntegrantesEquipo = @IntegrantesEquipo,
        EstadoEquipo = @EstadoEquipo
    WHERE
        NombreEquipo = @NombreEquipo
END
GO

CREATE PROCEDURE BorrarDatosEquipo
(
    @NombreEquipo VARCHAR(40)
)
AS
BEGIN
    DELETE FROM Equipo
    WHERE
        NombreEquipo = @NombreEquipo
END
GO



CREATE PROCEDURE InsertarDatosRelacionFamiliar
(
 
    @NombreShinobi1 VARCHAR(40),
    @NacimientoShinobi1 DATE,
    @NombreShinobi2 VARCHAR(40),
    @NacimientoShinobi2 DATE,
    @TipoRelacion VARCHAR(20)
)
AS
BEGIN
    INSERT INTO RelacionFamiliar ( NombreShinobi1, NacimientoShinobi1, NombreShinobi2, NacimientoShinobi2, TipoRelacion)
    VALUES ( @NombreShinobi1, @NacimientoShinobi1, @NombreShinobi2, @NacimientoShinobi2, @TipoRelacion)
END
GO

CREATE PROCEDURE ActualizarDatosRelacionFamiliar
(
    @Id_Relacion INT,
    @NombreShinobi1 VARCHAR(40),
    @NacimientoShinobi1 DATE,
    @NombreShinobi2 VARCHAR(40),
    @NacimientoShinobi2 DATE,
    @TipoRelacion VARCHAR(20)
)
AS
BEGIN
    UPDATE RelacionFamiliar
    SET
        TipoRelacion = @TipoRelacion
    WHERE
        Id_Relacion = @Id_Relacion AND
        NombreShinobi1 = @NombreShinobi1 AND
        NacimientoShinobi1 = @NacimientoShinobi1 AND
        NombreShinobi2 = @NombreShinobi2 AND
        NacimientoShinobi2 = @NacimientoShinobi2
END
GO

CREATE PROCEDURE BorrarDatosRelacionFamiliar
(
    @Id_Relacion INT,
    @NombreShinobi1 VARCHAR(40),
    @NacimientoShinobi1 DATE,
    @NombreShinobi2 VARCHAR(40),
    @NacimientoShinobi2 DATE
)
AS
BEGIN
    DELETE FROM RelacionFamiliar
    WHERE
        Id_Relacion = @Id_Relacion AND
        NombreShinobi1 = @NombreShinobi1 AND
        NacimientoShinobi1 = @NacimientoShinobi1 AND
        NombreShinobi2 = @NombreShinobi2 AND
        NacimientoShinobi2 = @NacimientoShinobi2
END
GO


CREATE PROCEDURE BorrarDatosAldea
(
    @NombreAldea VARCHAR(40)
)
AS
BEGIN
    DELETE FROM Aldea
    WHERE
        NombreAldea = @NombreAldea
END
GO

CREATE PROCEDURE ActualizarDatosEdificio
(
    @NombreEdificio VARCHAR(30),
    @CapacidadNinjas INT,
    @TipoEstructura VARCHAR(50),
    @NombreAldea VARCHAR(40)
)
AS
BEGIN
    UPDATE Edificio
    SET
        CapacidadNinjas = @CapacidadNinjas,
        TipoEstructura = @TipoEstructura,
        NombreAldea = @NombreAldea
    WHERE
        NombreEdificio = @NombreEdificio
END
GO



EXEC InsertarDatosAldea 'Konoha', 100000, 'Muy grande', 'Pais del Fuego'
EXEC InsertarDatosAldea 'Kumogakure', 60000, 'Mediano', 'Pais del Rayo'
EXEC InsertarDatosAldea 'Iwagakure', 80000, 'Grande', 'Pais de la Tierra'
EXEC InsertarDatosAldea 'Kirigakure', 20000, 'Pequeño', 'Pais del Agua'
EXEC InsertarDatosAldea 'Sunagakure', 30000, 'Pequeño', 'Pais del Viento'
EXEC InsertarDatosAldea 'Uzoshiogakure', 1000, 'Muy pequeño', 'Pais del Remolino'
EXEC InsertarDatosAldea 'Amegakure', 4000, 'Muy pequeño', 'Pais de la Lluvia'
EXEC InsertarDatosAldea 'Yugakure', 5000, 'Muy pequeño', 'Pais de las Aguas Termales'
EXEC InsertarDatosAldea 'Otogakure', 10000, 'Mediano', 'Pais del Sonido'
EXEC InsertarDatosAldea 'Kusagakure', 20000, 'Mediano', 'Pais de la Hierba'
EXEC InsertarDatosAldea 'Takigakure', 10000, 'Pequeño', 'Pais de la Cascada'
EXEC InsertarDatosAldea 'Shimogakure', 2000, 'Muy pequeño', 'Pais Helado'
EXEC InsertarDatosAldea 'Tanigakure', 5000, 'Mediano', 'Pais de los Rios'
EXEC InsertarDatosAldea 'Hoshigakure', 8000, 'Pequeño', 'Pais de los Osos'
EXEC InsertarDatosAldea 'Joumae', 500, 'Muy pequeño', 'Pais de las Llaves'
EXEC InsertarDatosAldea 'Takumi', 15000, 'Mediano', 'Pais de los Rios'
EXEC InsertarDatosAldea 'Tonbogakure', 8000, 'Pequeño', 'Pais de las Montañas'
EXEC InsertarDatosAldea 'Kemurigakure', 2000, 'Desconocido', 'Pais Desconocido'
EXEC InsertarDatosAldea 'Ishigakure', 5000, 'Pequeño', 'Pais de las Aves'
EXEC InsertarDatosAldea 'Getsugakure', 10000, 'Mediano', 'Pais de la Luna'
EXEC InsertarDatosAldea 'Desconocido', 100, 'Desconocido', 'Desconocido'

select * from Aldea


EXEC InsertarDatosEdificio 'Residencia del Hokage', 100, 'Administrativo', 'Konoha';
EXEC InsertarDatosEdificio 'Residencia del Kazekage', 80, 'Administrativo', 'Sunagakure';
EXEC InsertarDatosEdificio 'Residencia del Mizukage', 90, 'Administrativo', 'Kirigakure';
EXEC InsertarDatosEdificio 'Residencia del Tsuchikage', 70, 'Administrativo', 'Iwagakure';
EXEC InsertarDatosEdificio 'Residencia del Raikage', 85, 'Administrativo', 'Kumogakure';
EXEC InsertarDatosEdificio 'Torre del Sonido', 120, 'Estratégico', 'Otogakure';
EXEC InsertarDatosEdificio 'Torre de la Lluvia', 100, 'Estratégico', 'Amegakure';
EXEC InsertarDatosEdificio 'Torre de las Estrellas', 60, 'Estratégico', 'Hoshigakure';
EXEC InsertarDatosEdificio 'Torre de la Cascada', 80, 'Estratégico', 'Takigakure';
EXEC InsertarDatosEdificio 'Torre de la Luna', 50, 'Estratégico', 'Getsugakure';
EXEC InsertarDatosEdificio 'Torre de la Hierba', 130, 'Estratégico', 'Kusagakure';
EXEC InsertarDatosEdificio 'Torre de la Llave', 70, 'Estratégico', 'Yugakure';
EXEC InsertarDatosEdificio 'Torre del Valle', 90, 'Estratégico', 'Tanigakure';
EXEC InsertarDatosEdificio 'Torre de las Rocas', 100, 'Estratégico', 'Ishigakure';
EXEC InsertarDatosEdificio 'Torre de los Ríos', 110, 'Estratégico', 'Tanigakure';
EXEC InsertarDatosEdificio 'Casa de Sasuke', 10, 'Hogar', 'Konoha';
EXEC InsertarDatosEdificio 'Torre de las Olas', 95, 'Estratégico', 'Takumi';
EXEC InsertarDatosEdificio 'Ichiraku Ramen', 8, 'Comercial', 'Konoha' ;
EXEC InsertarDatosEdificio 'Torre de las Aves', 105, 'Estratégico', 'Ishigakure';
EXEC InsertarDatosEdificio 'Casa de Naruto', 10, 'Hogar', 'Konoha';

select * from Edificio

EXEC InsertarDatosClan 'Uchiha', 'Konoha', 1250, 'El fuego nunca se apaga', 'El emblema representa a un abanico con un ojo en el centro', 'Participó en la Gran Guerra Ninja';
EXEC InsertarDatosClan 'Hyuga', 'Konoha', 1200, 'La visión penetrante', 'El emblema representa a un ojo blanco y otro negro', 'Actuó como guardián en varias guerras';
EXEC InsertarDatosClan 'Nara', 'Konoha', 1300, 'Las sombras son nuestra fuerza', 'El emblema muestra una hoja y un ciervo', 'Participó en misiones tácticas cruciales';
EXEC InsertarDatosClan 'Akimichi', 'Konoha', 1280, 'El poder de la expansión', 'El emblema es una mariposa', 'Famoso por sus técnicas de aumento de tamaño';
EXEC InsertarDatosClan 'Aburame', 'Konoha', 1225, 'Unidos con los insectos', 'El emblema es un escarabajo', 'Especializados en técnicas con insectos';
EXEC InsertarDatosClan 'Inuzuka', 'Konoha', 1210, 'El mejor amigo del perro', 'El emblema muestra a un perro', 'Conocidos por sus compañeros caninos';
EXEC InsertarDatosClan 'Senju', 'Konoha', 1305, 'La fuerza de los bosques', 'El emblema es un conjunto de hojas', 'Fundadores de Konoha junto con los Uchiha';
EXEC InsertarDatosClan 'Kaguya', 'Kirigakure', 1100, 'El clan de los huesos', 'El emblema es una espina de hueso', 'Famosos por sus habilidades con los huesos';
EXEC InsertarDatosClan 'Hozuki', 'Kirigakure', 1150, 'La liquidez es nuestra arma', 'El emblema es una gota de agua', 'Conocidos por su habilidad para convertir sus cuerpos en agua';
EXEC InsertarDatosClan 'Yamanaka', 'Konoha', 1275, 'Intrusión mental total', 'El emblema muestra una flor', 'Especializados en técnicas de posesión mental';
EXEC InsertarDatosClan 'Kurama', 'Konoha', 1290, 'La voluntad de los nueve colas', 'El emblema representa a un zorro', 'Tienen una conexión especial con los Bijus';
EXEC InsertarDatosClan 'Temari', 'Sunagakure', 1220, 'La fuerza de los vientos', 'El emblema es un abanico de viento', 'Expertos en técnicas de viento';
EXEC InsertarDatosClan 'Kankuro', 'Sunagakure', 1222, 'El titiritero', 'El emblema es una marioneta', 'Maestros en el uso de marionetas en combate';
EXEC InsertarDatosClan 'Gaara', 'Sunagakure', 1235, 'El controlador de la arena', 'El emblema es una calabaza', 'Controla la arena con habilidades únicas';
EXEC InsertarDatosClan 'Darui', 'Kumogakure', 1270, 'El usuario del Elemento Rayo', 'El emblema es una nube oscura', 'Poseen habilidades únicas con el Elemento Rayo';
EXEC InsertarDatosClan 'Yotsuki', 'Kumogakure', 1215, 'El clan del Rayo Negro', 'El emblema es un rayo', 'Conocidos por sus técnicas con el Elemento Rayo';
EXEC InsertarDatosClan 'Hatake', 'Konoha', 1228, 'La sombra del Hokage', 'El emblema es un perro con un hoja', 'Famosos por el Sharingan de Kakashi';
EXEC InsertarDatosClan 'Uzumaki', 'Uzoshiogakure', 1105, 'La espiral infinita', 'El emblema es una espiral', 'Conocidos por su longevidad y habilidades en sellos';
EXEC InsertarDatosClan 'Sarutobi', 'Konoha', 1260, 'La llama de la vida', 'El emblema es un mono', 'Varios miembros han sido Hokages';
EXEC InsertarDatosClan 'Shirogane', 'Sunagakure', 1150, 'Los marionetistas', 'El emblema es una marca de maldición amarilla', 'Conocidos por sus marionetas';
EXEC InsertarDatosClan 'Desconocido', 'Desconocido', 1000, 'Desconocido', 'Desconocido', 'Desconocido';

select * from Clan

EXEC InsertarDatosEquipo 'Equipo 10', 2010, 3, 'Activo';
EXEC InsertarDatosEquipo 'Equipo Kakashi', 2010, 5, 'Disuelto'
EXEC InsertarDatosEquipo 'Equipo 2', 1995, 5, 'Inactivo';
EXEC InsertarDatosEquipo 'Equipo de Rescate', 2003, 6, 'Activo';
EXEC InsertarDatosEquipo 'Equipo Medic', 1998, 4, 'Activo';
EXEC InsertarDatosEquipo 'Los Sannin', 1985, 3, 'Disuelto';
EXEC InsertarDatosEquipo 'Equipo de Exploración', 2008, 5, 'Activo';
EXEC InsertarDatosEquipo 'Equipo de Inteligencia', 2001, 4, 'Activo';
EXEC InsertarDatosEquipo 'Equipo de Asesinos', 1992, 3, 'Inactivo';
EXEC InsertarDatosEquipo 'Equipo de Guardia', 2005, 6, 'Activo';
EXEC InsertarDatosEquipo 'Equipo Táctico', 2015, 4, 'Activo';
EXEC InsertarDatosEquipo 'Equipo de Apoyo', 2006, 5, 'Inactivo';
EXEC InsertarDatosEquipo 'Equipo de Entrenamiento', 2012, 3, 'Activo';
EXEC InsertarDatosEquipo 'Equipo de Combate', 2004, 4, 'Activo';
EXEC InsertarDatosEquipo 'Equipo de Reconocimiento', 1999, 5, 'Activo';
EXEC InsertarDatosEquipo 'Equipo de Asalto', 2007, 6, 'Inactivo';
EXEC InsertarDatosEquipo 'Equipo de Caza', 2018, 3, 'Activo';
EXEC InsertarDatosEquipo 'Equipo de Vigilancia', 1990, 4, 'Activo';
EXEC InsertarDatosEquipo 'Equipo de Espionaje', 2011, 5, 'Inactivo';
EXEC InsertarDatosEquipo 'Equipo de Contrainteligencia', 2009, 6, 'Activo';
EXEC InsertarDatosEquipo 'Equipo de Reserva', 2019, 4, 'Activo';
EXEC InsertarDatosEquipo 'Equipo Desconocido', 1000, 100, 'Activo';
EXEC InsertarDatosEquipo 'Equipo Senju', 1830, 50, 'Inactivo';
EXEC InsertarDatosEquipo 'Anbu', 1900, 40, 'Activo';

select * from Equipo

EXEC InsertarDatosEspecie 'Humano Uchiha', 'Extinto', 'Neutral', 'Sharingan';
EXEC InsertarDatosEspecie 'Humano Hyuga', 'Vivo', 'Pacífico', 'Byakugan';
EXEC InsertarDatosEspecie 'Akatsuki', 'Extinto', 'Hostil', 'Jutsus Oscuros';
EXEC InsertarDatosEspecie 'Humano', 'Vivo', 'Neutral', 'Ninguna';
EXEC InsertarDatosEspecie 'Serpiente Blanca', 'Viva', 'Hostil', 'Control de Serpientes';
EXEC InsertarDatosEspecie 'Mariposa Gigante', 'Viva', 'Neutral', 'Control de Polillas';
EXEC InsertarDatosEspecie 'Rana', 'Viva', 'Pacífica', 'Invocación de Jiraiya';
EXEC InsertarDatosEspecie 'Jinchuriki', 'Vivo', 'Neutral', 'Chakra Masivo';
EXEC InsertarDatosEspecie 'Slug', 'Viva', 'Neutral', 'Curación Poderosa';
EXEC InsertarDatosEspecie 'Gato', 'Vivo', 'Pacífico', 'Jutsus Místicos';
EXEC InsertarDatosEspecie 'Insectos Kikaichu', 'Vivos', 'Neutral', 'Control Insectoide';
EXEC InsertarDatosEspecie 'Pájaro Mensajero', 'Vivo', 'Pacífico', 'Comunicación a Distancia';
EXEC InsertarDatosEspecie 'Perro Ninja', 'Vivo', 'Pacífico', 'Seguimiento y Rastreo';
EXEC InsertarDatosEspecie 'Ciervo', 'Vivo', 'Pacífico', 'Asistencia en Combate';
EXEC InsertarDatosEspecie 'Serpiente Gigante', 'Viva', 'Hostil', 'Constricción Poderosa';
EXEC InsertarDatosEspecie 'Tigre', 'Vivo', 'Neutral', 'Fuerza y Agilidad';
EXEC InsertarDatosEspecie 'Murciélago', 'Vivo', 'Neutral', 'Ecolocalización';
EXEC InsertarDatosEspecie 'León', 'Vivo', 'Pacífico', 'Fuerza y Valor';
EXEC InsertarDatosEspecie 'Araña', 'Viva', 'Hostil', 'Tejido de Seda y Trampas';
EXEC InsertarDatosEspecie 'Tortuga', 'Viva', 'Neutral', 'Defensa Poderosa';
EXEC InsertarDatosEspecie 'Gorila Gigante', 'Vivo', 'Pacífico', 'Fuerza Descomunal';
EXEC InsertarDatosEspecie 'Bestia con Cola', 'Vivo', 'Hostil', 'Poder Infinito';
EXEC InsertarDatosEspecie 'Dios', 'Vivo', 'Neutral', 'Divinidad';
EXEC InsertarDatosEspecie 'Sapo', 'Viva', 'Pacífica', 'Invocación de Jiraiya';

select * from Especie

EXEC InsertarDatosShinobi 'Naruto Uzumaki', '10-10-1997', 'Vivo', 'Konoha', 'Uzumaki', 'Equipo Kakashi', 'Jinchuriki';
EXEC InsertarDatosShinobi 'Sasuke Uchiha', '23-07-1997', 'Vivo', 'Konoha', 'Uchiha', 'Equipo Kakashi', 'Humano Uchiha';
EXEC InsertarDatosShinobi 'Hinata Hyuga', '27-12-1999', 'Viva', 'Konoha', 'Hyuga', 'Equipo 8', 'Humano Hyuga';
EXEC InsertarDatosShinobi 'Shikamaru Nara', '22-09-1998', 'Vivo', 'Konoha', 'Nara', 'Equipo 10', 'Humano';
EXEC InsertarDatosShinobi 'Choji Akimichi', '01-05-1997', 'Vivo', 'Konoha', 'Akimichi', 'Equipo 10', 'Humano';
EXEC InsertarDatosShinobi 'Shino Aburame', '23-01-1999', 'Vivo', 'Konoha', 'Aburame', 'Equipo 8', 'Humano';
EXEC InsertarDatosShinobi 'Kiba Inuzuka', '07-07-1999', 'Vivo', 'Konoha', 'Inuzuka', 'Equipo 8', 'Humano';
EXEC InsertarDatosShinobi 'Orochimaru Senji', '01-10-1975', 'Retirado', 'Otogakure', 'Desconocido', 'Los Sannin', 'Humano';
EXEC InsertarDatosShinobi 'Kaguya Otsutsuki', '10-03-1250', 'Desconocido', 'Desconocido', 'Kaguya', 'Equipo Desconocido', 'Dios';
EXEC InsertarDatosShinobi 'Suigetsu Hozuki', '18-02-1996', 'Vivo', 'Kirigakure', 'Desconocido', 'Equipo de combate', 'Humano';
EXEC InsertarDatosShinobi 'Ino Yamanaka', '23-09-1997', 'Viva', 'Konoha', 'Yamanaka', 'Equipo 10', 'Humano';
EXEC InsertarDatosShinobi 'Kurama', '10-10-1997', 'Vivo', 'Desconocido', 'Kurama', 'Equipo Kakashi', 'Bestia con Cola';
EXEC InsertarDatosShinobi 'Temari', '23-08-1994', 'Viva', 'Sunagakure', 'Temari', 'Equipo de Exploración', 'Humano';
EXEC InsertarDatosShinobi 'Kankuro', '15-05-1996', 'Vivo', 'Sunagakure', 'Kankuro', 'Equipo de Exploración', 'Humano';
EXEC InsertarDatosShinobi 'Gaara', '19-01-1995', 'Vivo', 'Sunagakure', 'Gaara', 'Equipo de Exploración', 'Jinchuriki';
EXEC InsertarDatosShinobi 'Darui', '02-02-1996', 'Vivo', 'Kumogakure', 'Darui', 'Equipo de combate', 'Humano';
EXEC InsertarDatosShinobi 'Yurui Yotsuki', '15-11-2002', 'Vivo', 'Kumogakure', 'Yotsuki', 'Equipo 11', 'Humano';
EXEC InsertarDatosShinobi 'Kakashi Hatake', '15-09-1970', 'Retirado', 'Konoha', 'Hatake', 'Equipo Kakashi', 'Humano';
EXEC InsertarDatosShinobi 'Hiruzen Sarutobi', '10-02-1939', 'Fallecido', 'Konoha', 'Sarutobi', 'Los Sannin', 'Humano';
EXEC InsertarDatosShinobi 'Shirogane', '22-06-1995', 'Desconocido', 'Desconocido', 'Shirogane', 'Equipo Desconocido', 'Humano';
EXEC InsertarDatosShinobi 'Madara Uchiha', '24-12-1848', 'Fallecido', 'Konoha', 'Uchiha', 'Equipo Desconocido', 'Humano Uchiha';
EXEC InsertarDatosShinobi 'Hashirama Senju', '23-02-1813', 'Fallecido', 'Konoha', 'Senju', 'Equipo Senju', 'Humano';
EXEC InsertarDatosShinobi 'Tobirama Senju', '01-01-1818', 'Fallecido', 'Konoha', 'Senju', 'Equipo Senju', 'Humano';
EXEC InsertarDatosShinobi 'Itachi Uchiha', '09-06-1984', 'Fallecido', 'Konoha', 'Uchiha', 'Anbu', 'Humano Uchiha';
EXEC InsertarDatosShinobi 'Jiraiya', '03-11-1958', 'Fallecido', 'Konoha', 'Desconocido', 'Los sannin', 'Humano';
EXEC InsertarDatosShinobi 'Gamabunta', '03-01-1999', 'Vivo', 'Konoha', 'Desconocido', 'Equipo Desconocido', 'Sapo';
EXEC InsertarDatosShinobi 'Sakura Haruno', '28-04-1997', 'Vivo', 'Konoha', 'Desconocido', 'Equipo Kakashi', 'Humano';

select * from Shinobi

EXEC InsertarDatosRelacionFamiliar 'Naruto Uzumaki', '10-10-1997', 'Hinata Hyuga', '27-12-1999', 'Esposo';
EXEC InsertarDatosRelacionFamiliar 'Madara Uchiha', '24-12-1848', 'Sasuke Uchiha', '23-07-1997', 'Tatarabuelo';
EXEC InsertarDatosRelacionFamiliar 'Sasuke Uchiha', '23-07-1997', 'Sakura Haruno', '28-04-1997', 'Esposo';
EXEC InsertarDatosRelacionFamiliar 'Itachi Uchiha', '09-06-1984','Sasuke Uchiha', '23-07-1997', 'Hermano';
EXEC InsertarDatosRelacionFamiliar 'Temari', '23-08-1994', 'Shikamaru Nara', '22-09-1998', 'Esposa';

select * from RelacionFamiliar

EXEC InsertarHabilidad 'Chidori', 'Kakashi Hatake', 'Ninjutsu';
EXEC InsertarHabilidad 'Rasengan', 'Minato Namikaze', 'Ninjutsu';
EXEC InsertarHabilidad 'Byakugan', 'Hinata Hyuga', 'Dojutsu';
EXEC InsertarHabilidad 'Técnica de Posesión de Sombras', 'Shikamaru Nara', 'Ninjutsu';
EXEC InsertarHabilidad 'Modo Mariposa Choji', 'Choji Akimichi', 'Hijo del Clan Akimichi';
EXEC InsertarHabilidad 'Técnica de Clonación de Insectos', 'Shino Aburame', 'Ninjutsu';
EXEC InsertarHabilidad 'Lobo de Tres Cabezas', 'Kiba Inuzuka', 'Ninjutsu';
EXEC InsertarHabilidad 'Modo Sabio de la Serpiente', 'Orochimaru', 'Senjutsu';
EXEC InsertarHabilidad 'Liberación de Hielo: Tormenta del Dragón Negro', 'Suigetsu Hozuki', 'Kekkei Genkai';
EXEC InsertarHabilidad 'Técnica de Transferencia de Mente', 'Ino Yamanaka', 'Ninjutsu';
EXEC InsertarHabilidad 'Susanoo del Mangekyo Sharingan', 'Sasuke Uchiha', 'Kekkei Genkai';
EXEC InsertarHabilidad 'Cofre de Arena', 'Gaara', 'Ninjutsu';
EXEC InsertarHabilidad 'Técnica de Marionetas', 'Kankuro', 'Ninjutsu';
EXEC InsertarHabilidad 'Técnica de la Guadaña de Viento', 'Temari', 'Ninjutsu';
EXEC InsertarHabilidad 'Liberación de Tormenta: Circo Láser', 'Darui', 'Kekkei Genkai';
EXEC InsertarHabilidad 'Liberación de Lava: Técnica de la Aparición Fundente', 'Kurotsuchi', 'Kekkei Genkai';
EXEC InsertarHabilidad 'Técnica de la Prisión de Agua: Baile del Tiburón', 'Yurui Yotsuki', 'Ninjutsu';
EXEC InsertarHabilidad 'Kamui', 'Kakashi Hatake', 'Mangekyo Sharingan';
EXEC InsertarHabilidad 'Técnica de Clonación de Shurikens', 'Hiruzen Sarutobi', 'Ninjutsu';
EXEC InsertarHabilidad 'Liberación de Acero: Armadura Impenetrable', 'Shirogane', 'Kekkei Genkai';
EXEC InsertarHabilidad 'Técnica de Clonación de Sombras', 'Naruto Uzumaki', 'Ninjutsu';
EXEC InsertarHabilidad 'Técnica de Teletransportación', 'Minato Namikaze', 'Ninjutsu';

select * from Habilidad

EXEC InsertarDatosConflicto 'Gran Guerra Ninja', '10-05-1120', 'Valle del Fin', 50000;
EXEC InsertarDatosConflicto 'Guerra contra Akatsuki', '15-02-2014', 'Varios lugares', 3000;
EXEC InsertarDatosConflicto 'Conflicto en la Arena', '25-07-1980', 'Desierto de Suna', 1200;
EXEC InsertarDatosConflicto 'Invasión a Konoha', '03-11-1100', 'Konoha', 2500;
EXEC InsertarDatosConflicto 'Guerra de los Cinco Kages', '20-06-2015', 'Varias aldeas', 10;
EXEC InsertarDatosConflicto 'Batalla en el País de la Cascada', '12-09-1980', 'País de la Cascada', 800;
EXEC InsertarDatosConflicto 'Conflicto con el Clan Uchiha', '05-03-1990', 'Bosque de Konoha', 700;
EXEC InsertarDatosConflicto 'Guerra contra los Bandidos del País de la Lluvia', '08-12-1990', 'País de la Lluvia', 1500;
EXEC InsertarDatosConflicto 'Incidente del Puente Kannabi', '18-01-1960', 'Puente Kannabi', 300;
EXEC InsertarDatosConflicto 'Invasión a la Aldea Oculta de la Arena', '29-04-1980', 'Suna', 1800;
EXEC InsertarDatosConflicto 'Guerra en el País de las Olas', '02-08-1940', 'País de las Olas', 600;
EXEC InsertarDatosConflicto 'Rebelión de los Bandidos del Bosque', '14-07-1950', 'Bosque de Konoha', 400;
EXEC InsertarDatosConflicto 'Conflicto con los Ninjas del País de la Nieve', '09-06-1975', 'País de la Nieve', 1000;
EXEC InsertarDatosConflicto 'Batalla en el Monte Myoboku', '23-10-1935', 'Monte Myoboku', 120;
EXEC InsertarDatosConflicto 'Invasión a la Aldea Oculta de la Lluvia', '30-03-1985', 'Amegakure', 2200;
EXEC InsertarDatosConflicto 'Conflicto en el País de los Campos de Arroz', '11-04-1965', 'País de los Campos de Arroz', 500;
EXEC InsertarDatosConflicto 'Batalla contra Zabuza y Haku', '07-12-2010', 'Puente Kannabi', 20;
EXEC InsertarDatosConflicto 'Guerra contra los Bandidos de la Cascada', '05-09-1955', 'País de la Cascada', 350;
EXEC InsertarDatosConflicto 'Invasión a la Aldea Oculta de la Hierba', '26-08-1215', 'Kusa', 900;
EXEC InsertarDatosConflicto 'Conflicto en el País de la Luna', '16-01-2025', 'País de la Luna', 200;

select * from Conflicto

--consulta 1: 
--Mostrar los equipos con sus integrantes y la aldea a la que pertenecen
SELECT
    E.NombreEquipo,
    E.IntegrantesEquipo,
    S.NombreShinobi,
    S.AldeaOculta
FROM
    Equipo E
JOIN Shinobi S ON E.NombreEquipo = S.NombreEquipo;


--Consulta 2: 
--devuelve una lista de estados de shinobi junto con el número total de shinobis asociados a cada estado.
SELECT EstatusShinobi, COUNT(*) AS TotalShinobis
FROM Shinobi
GROUP BY EstatusShinobi;
GO

--Consulta 3: 
--devuelve el nombre de las especies para las cuales no hay shinobis en la tabla Shinobi con esa especie.
SELECT E.NombreEspecie
FROM Especie E
WHERE NOT EXISTS (SELECT 1 FROM Shinobi S WHERE E.NombreEspecie = S.NombreEspecie);
GO

--Consulta 4: 
--devuelve una lista de clanes con sus respectivos emblemas y el total de shinobis únicos asociados a cada clan, 
--ordenados de mayor a menor según el número de shinobis.
SELECT Clan.NombreClan, Clan.DescripcionEmblema, COUNT(DISTINCT Shinobi.NombreShinobi) AS TotalShinobis
FROM Clan
LEFT JOIN Shinobi ON Clan.NombreClan = Shinobi.NombreClan
GROUP BY Clan.NombreClan, Clan.DescripcionEmblema
ORDER BY TotalShinobis DESC;
GO

--Consulta 5: 
--selecciona el nombre y la fecha de nacimiento de los shinobi cuya fecha de nacimiento es posterior al 1 de enero de 1990. 
SELECT NombreShinobi, NacimientoShinobi
FROM Shinobi
WHERE NacimientoShinobi > '1990-01-01';
GO

--Consulta 6: 
--cuenta el número total de especies distintas que están asociadas a algún shinobi en la base de datos.
SELECT COUNT(DISTINCT Especie.NombreEspecie) AS TotalEspecies
FROM Especie
JOIN Shinobi ON Especie.NombreEspecie = Shinobi.NombreEspecie;
GO

--Consulta 7: 
--selecciona el nombre y la cantidad de integrantes del equipo que tiene el minimo número de integrantes en la tabla Equipo.
SELECT NombreEquipo, IntegrantesEquipo
FROM Equipo
WHERE IntegrantesEquipo = (SELECT min(IntegrantesEquipo) FROM Equipo);
GO

--Consulta 8: 
--Habilidades de un tipo específico:
SELECT
    H.NombreHabilidad,
    H.TipoHabilidad
FROM
    Habilidad H
WHERE
    H.TipoHabilidad = 'Ninjutsu';

--Consulta 9: 
--Shinobis nacidos en una fecha específica con detalles de su clan:
SELECT
    S.NombreShinobi,
    S.NacimientoShinobi,
    C.NombreClan,
    C.LemaClan
FROM
    Shinobi S
LEFT JOIN
    Clan C ON S.NombreClan = C.NombreClan
WHERE
    S.NacimientoShinobi = '10-10-1997';

--Consulta 10: 
--Consulta SELECT para obtener la lista de conflictos y sus fechas ordenados por fecha descendente:
SELECT NombreConflicto, FechaConflicto
FROM Conflicto
ORDER BY FechaConflicto DESC;

--Consulta 11: 
--Consulta SELECT con JOIN y agregación para obtener el número promedio de habitantes por aldea:
SELECT A.NombreAldea, AVG(A.HabitantesAldea) AS PromedioHabitantes
FROM Aldea A
LEFT JOIN Shinobi S ON A.NombreAldea = S.AldeaOculta
GROUP BY A.NombreAldea;

--Consulta 12:
--Creación de una Vista que muestra la información de Shinobis con sus Aldeas, Clanes y Equipos asociados:
CREATE VIEW VistaShinobiInfo AS
SELECT S.NombreShinobi, S.NacimientoShinobi, S.EstatusShinobi, A.NombreAldea, C.NombreClan, E.NombreEquipo
FROM Shinobi S
LEFT JOIN Aldea A ON S.AldeaOculta = A.NombreAldea
LEFT JOIN Clan C ON S.NombreClan = C.NombreClan
LEFT JOIN Equipo E ON S.NombreEquipo = E.NombreEquipo;

SELECT * FROM VistaShinobiInfo;

--Consulta 13:
--Consulta JOIN INNER para obtener información de Shinobis y sus Clanes asociados:
SELECT S.NombreShinobi, S.NacimientoShinobi, S.EstatusShinobi, C.NombreClan
FROM Shinobi S
INNER JOIN Clan C ON S.NombreClan = C.NombreClan;

--Consulta 14:
--Consulta SELECT con filtro y ordenamiento:
SELECT NombreClan, LemaClan
FROM Clan
WHERE ParticipacionConflicto = 'Participó en la Gran Guerra Ninja'
ORDER BY LemaClan ASC;

--Consulta 15:
--Consulta JOIN RIGHT para obtener todos los Edificios y las Aldeas asociadas (si las hay):
SELECT E.NombreEdificio, E.CapacidadNinjas, E.TipoEstructura, A.NombreAldea, A.HabitantesAldea
FROM Edificio E
RIGHT JOIN Aldea A ON E.NombreAldea = A.NombreAldea;

--Consulta 16:
--Consulta JOIN LEFT para obtener todas las Aldeas y los Edificios asociados (si los hay):
SELECT A.NombreAldea, A.HabitantesAldea, A.TerritorioAldea, E.NombreEdificio, E.CapacidadNinjas
FROM Aldea A
LEFT JOIN Edificio E ON A.NombreAldea = E.NombreAldea;

--Consulta 17:
--Cuenta el número de shinobis para cada estado de shinobi.
SELECT NombreShinobi,EstatusShinobi, COUNT(*) AS CantidadShinobis
FROM Shinobi
GROUP BY NombreShinobi,EstatusShinobi;

--Consulta18 
--Obtiene el nombre del clan y la cantidad de conflictos en los que ha participado, ordenado por la cantidad de participaciones en orden descendente.
SELECT
    C.NombreClan,
    COUNT(CC.NombreConflicto) AS CantidadParticipaciones
FROM
    Clan C
LEFT JOIN
    ClanConflicto CC ON C.AldeaOculta = CC.NombreAldea
GROUP BY
    C.NombreClan
ORDER BY
    CantidadParticipaciones DESC;

--Consulta 19:
--Obtiene el nombre del equipo y la fundación del equipo para los equipos inactivos.
SELECT NombreEquipo, FundacionEquipo
FROM Equipo
WHERE EstadoEquipo = 'Inactivo';

--Consulta 20:
--Obtiene el nombre del shinobi, la fecha de nacimiento, la aldea oculta y la especie para los shinobis de la aldea 'Konoha' y de especie 'Humana'
SELECT NombreShinobi,NacimientoShinobi, AldeaOculta,NombreEspecie
FROM Shinobi
WHERE AldeaOculta = 'Konoha' AND NombreEspecie = 'Humano';