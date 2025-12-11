DROP DATABASE IF EXISTS nombre_de_tu_base_de_datos;
CREATE DATABASE nombre_de_tu_base_de_datos;
USE nombre_de_tu_base_de_datos;

CREATE TABLE categories (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (255) NOT NULL UNIQUE,
    image VARCHAR (255) NOT NULL,
    color VARCHAR(255) NOT NULL
);

CREATE TABLE subcategories (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (255) NOT NULL UNIQUE,
    image VARCHAR (255) NOT NULL,
    id_category INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_category) REFERENCES categories(id) ON DELETE CASCADE,
    color VARCHAR(255) NOT NULL
);

CREATE TABLE diets (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (255) NOT NULL UNIQUE,
	color VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE animals (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (100) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    inteligence INT UNSIGNED NOT NULL,
    height DECIMAL (10,2) NOT NULL,
    weight DECIMAL (10,2) NOT NULL,
    speed INT UNSIGNED NOT NULL,
    danger INT UNSIGNED NOT NULL,
    longevity INT UNSIGNED NOT NULL,
    image VARCHAR (255) NOT NULL,
    id_subcategory INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_subcategory) REFERENCES subcategories(id) ON DELETE CASCADE,
    id_diet INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_diet) REFERENCES diets(id) ON DELETE CASCADE
);

CREATE TABLE types (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (255) NOT NULL UNIQUE,
    color VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL
);


CREATE TABLE animal_types (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_animal INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_animal) REFERENCES animals(id) ON DELETE CASCADE,
    id_type INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_type) REFERENCES types(id) ON DELETE CASCADE
);

CREATE TABLE users (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR (100) NOT NULL UNIQUE,
    username VARCHAR (25) NOT NULL UNIQUE,
    password VARCHAR (255) NOT NULL,
    token VARCHAR(255) DEFAULT ''
);


-- Categories
INSERT INTO categories (id, name, image, color) VALUES (1, 'MAMÍFEROS', 'leon.png', '#A0522D');
INSERT INTO categories (id, name, image, color) VALUES (2, 'AVES', 'aguila.png', '#FF8C00');
INSERT INTO categories (id, name, image, color) VALUES (3, 'REPTILES', 'cocodrilo_africano.png', '#228B22');
INSERT INTO categories (id, name, image, color) VALUES (4, 'ANFIBIOS', 'rana_comun.png', '#32CD32');
INSERT INTO categories (id, name, image, color) VALUES (5, 'MARINOS', 'tiburon_blanco.png', '#1E90FF');

-- Subcategories Mamíferos
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (1, 'FELINOS', 'leon.png', 1, '#FF4500');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (2, 'CANINOS', 'perro_rotweiler.png', 1, '#8B0000');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (3, 'PRIMATES', 'gorila.png', 1, '#CD853F');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (4, 'OSOS', 'oso_pardo.png', 1, '#A0522D');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (5, 'ROEDORES', 'raton.png', 1, '#D2691E');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (6, 'LAGOMORFOS', 'conejo.png', 1, '#F4A460');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (7, 'PAQUIDERMOS', 'elefante.png', 1, '#8B4513');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (8, 'MARSUPIALES', 'canguro.png', 1, '#FF6347');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (9, 'CETACEOS', 'delfin.png', 1, '#4682B4');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (10, 'CÉRVIDOS', 'ciervo_rojo.png', 1, '#DEB887');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (11, 'BOVINOS', 'vaca.png', 1, '#BC8F8F');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (12, 'EQUINOS', 'caballo.png', 1, '#DAA520');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (13, 'PUERCOS', 'cerdo.png', 1, '#CD5C5C');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (14, 'PINNÍPEDOS', 'foca.png', 1, '#20B2AA');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (15, 'OVINOS Y CAPRINOS', 'oveja.png', 1, '#F5DEB3');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (16, 'GIRAFFIDOS', 'jirafa.png', 1, '#FFE4B5');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (17, 'XENATRAS', 'armadillo.png', 1, '#B0C4DE');

-- Subcategories Aves
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (18, 'AVES RAPACES', 'aguila.png', 2, '#8B4513');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (19, 'AVES ACUÁTICAS', 'pato_azulon.png', 2, '#00CED1');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (20, 'AVES TERRESTRES', 'avestruz.png', 2, '#DAA520');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (21, 'AVES COMUNES', 'paloma.png', 2, '#5F9EA0');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (22, 'AVES ZANCUDAS', 'flamenco.png', 2, '#FF69B4');

-- Subcategories Reptiles
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (23, 'SERPIENTES', 'serpiente_comun.png', 3, '#556B2F');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (24, 'LAGARTOS', 'dragon_de_komodo.png', 3, '#6B8E23');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (25, 'TORTUGAS', 'tortuga_terrestre.png', 3, '#2E8B57');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (26, 'COCODRILIANOS', 'cocodrilo_africano.png', 3, '#008000');

-- Subcategories Anfibios
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (27, 'RANAS', 'rana_comun.png', 4, '#7FFF00');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (28, 'SALAMANDRAS', 'ajolote.png', 4, '#ADFF2F');

-- Subcategories Marinos
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (29, 'PECES', 'pez_payaso.png', 5, '#1E90FF');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (30, 'TIBURONES', 'tiburon_blanco.png', 5, '#4682B4');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (31, 'CRUSTÁCEOS', 'cangrejo.png', 5, '#FF6347');
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (32, 'MOLUSCOS', 'pulpo.png', 5, '#DA70D6');

-- Subcategoria extra Mamiferos
INSERT INTO subcategories (id, name, image, id_category, color) VALUES (33, 'MONOTERMOS', 'ornitorrinco.png', 1, '#8B6D5C');


-- INSERTS Dietas
INSERT INTO diets (id, name, color, description) VALUES (1, 'Omnívoros', '#8B4513', 'Combinan Vegetales, carne y demás alimentos');
INSERT INTO diets (id, name, color, description) VALUES (2, 'Carnívoros', '#B22222','Depredadores o carroñeros que comen carne');
INSERT INTO diets (id, name, color, description) VALUES (3, 'Herbívoros', '#32CD32','Comen plantas, frutas o materia vegetal');


-- INSERTS Tipos
INSERT INTO types (name, color,description) VALUES
('Terrestre', '#8B5E3C','Organismos adaptados a vivir y desplazarse sobre tierra firme'),
('Acuático', '#1E90FF','Su medio natural es el agua y realizan allí sus funciones vitales'),
('Semiacuático', '#4CA3DD','Pueden vivir tanto en tierra como en agua'),
('Volador', '#FFD700','Organismos capaces de desplazarse por el aire mediante vuelo o planeo'),
('Doméstico', '#FFA500','Animales que viven con los seres humanos'),
('Arbóreo', '#8BC34A','Organismos que sobreviven en los árboles');


-- INSERTS Animales (Cabe recalcar que los datos son todos genericos, editar desde el admin)
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Aguila', 'Aguila descripción.', 50, 1.00, 100.00, 20, 30, 10, 'aguila.png', 18, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Ajolote', 'Ajolote descripción.', 50, 1.00, 120.00, 20, 30, 10, 'ajolote.png', 28, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Alce', 'Alce descripción.', 50, 1.00, 120.00, 20, 30, 10, 'alce.png', 10, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Antilope', 'Antilope descripción.', 50, 1.00, 234.00, 20, 30, 10, 'antilope.png', 10, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Ardilla', 'Ardilla descripción.', 50, 1.00, 1.00, 20, 30, 10, 'ardilla.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Ardilla Voladora', 'Ardilla Voladora descripción.', 50, 1.00, 1.00, 20, 30, 10, 'ardilla_voladora.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Armadillo', 'Armadillo descripción.', 50, 55.00, 1.00, 20, 30, 10, 'armadillo.png', 17, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Atun', 'Atun descripción.', 50, 1.00, 10.00, 20, 30, 10, 'atun.png', 29, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Avestruz', 'Avestruz descripción.', 50, 1.00, 10.00, 20, 30, 10, 'avestruz.png', 20, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Babuino', 'Babuino descripción.', 50, 1.00, 10.00, 20, 30, 10, 'babuino.png', 3, 1);

INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Bacalao', 'Bacalao descripción.', 50, 23.00, 560.00, 20, 30, 10, 'bacalao.png', 29, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Ballena Azull', 'Ballena Azull descripción.', 50, 1.00, 10.00, 20, 30, 10, 'ballena_azull.png', 9, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Beluga', 'Beluga descripción.', 50, 1.00, 10.00, 20, 30, 10, 'beluga.png', 9, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Bisonte', 'Bisonte descripción.', 50, 1.00, 10.00, 20, 30, 10, 'bisonte.png', 11, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Boa Constrictora', 'Boa Constrictora descripción.', 50, 1.00, 10.00, 20, 30, 10, 'boa_constrictora.png', 23, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Buffalo', 'Buffalo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'buffalo.png', 11, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Buho', 'Buho descripción.', 50, 1.00, 10.00, 20, 30, 10, 'buho.png', 18, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Burro', 'Burro descripción.', 50, 1.00, 1.00, 20, 30, 1, 'burro.png', 12, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Caballo', 'Caballo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'caballo.png', 12, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cabra Domestica', 'Cabra Domestica descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cabra_domestica.png', 15, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cabra Montesa', 'Cabra Montesa descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cabra_montesa.png', 15, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cachalote', 'Cachalote descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cachalote.png', 9, 1);

INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Caiman', 'Caiman descripción.', 50, 1.00, 10.00, 20, 30, 10, 'caiman.png', 26, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Calamar', 'Calamar descripción.', 50, 1.00, 10.00, 20, 30, 10, 'calamar.png', 32, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Camaleon', 'Camaleon descripción.', 50, 1.00, 10.00, 20, 30, 10, 'camaleon.png', 24, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Camello Bactriano', 'Camello Bactriano descripción.', 50, 1.00, 10.00, 20, 30, 10, 'camello_bactriano.png', 12, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Camello Dromedario', 'Camello Dromedario descripción.', 50, 1.00, 10.00, 20, 30, 10, 'camello_dromedario.png', 12, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cangrejo', 'Cangrejo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cangrejo.png', 31, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cangrejo Ermitaño', 'Cangrejo Ermitaño descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cangrejo_ermitaño.png', 31, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cangrejo Gigante', 'Cangrejo Gigante descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cangrejo_gigante.png', 31, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Canguro', 'Canguro descripción.', 50, 1.00, 10.00, 20, 30, 10, 'canguro.png', 8, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Capibara', 'Capibara descripción.', 50, 1.00, 10.00, 20, 30, 10, 'capibara.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Caracol Marino', 'Caracol Marino descripción.', 50, 1.00, 10.00, 20, 30, 10, 'caracol_marino.png', 32, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Carnero', 'Carnero descripción.', 50, 1.00, 10.00, 20, 30, 10, 'carnero.png', 15, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Carpa', 'Carpa descripción.', 50, 1.00, 10.00, 20, 30, 10, 'carpa.png', 29, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Castor', 'Castor descripción.', 50, 1.00, 10.00, 20, 30, 10, 'castor.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cerdo', 'Cerdo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cerdo.png', 13, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Chimpance', 'Chimpance descripción.', 50, 1.00, 10.00, 20, 30, 10, 'chimpance.png', 3, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Ciervo Cola Blanca', 'Ciervo Cola Blanca descripción.', 50, 1.00, 10.00, 20, 30, 10, 'ciervo_cola_blanca.png', 10, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Ciervo Rojo', 'Ciervo Rojo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'ciervo_rojo.png', 10, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cigueña', 'Cigueña descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cigueña.png', 22, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cisne', 'Cisne descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cisne.png', 19, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cobaya', 'Cobaya descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cobaya.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cobra Real', 'Cobra Real descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cobra_real.png', 23, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cocodrilo Africano', 'Cocodrilo Africano descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cocodrilo_africano.png', 26, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cocodrilo Americano', 'Cocodrilo Americano descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cocodrilo_americano.png', 26, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cocodrilo Enano', 'Cocodrilo Enano descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cocodrilo_enano.png', 26, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Condor', 'Condor descripción.', 50, 1.00, 10.00, 20, 30, 10, 'condor.png', 18, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Conejo', 'Conejo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'conejo.png', 6, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Corre Caminos', 'Corre Caminos descripción.', 50, 1.00, 10.00, 20, 30, 10, 'corre_caminos.png', 20, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Coyote', 'Coyote descripción.', 50, 1.00, 10.00, 20, 30, 10, 'coyote.png', 2, 1);

INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Cuervo', 'Cuervo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'cuervo.png', 21, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Delfin', 'Delfin descripción.', 50, 1.00, 10.00, 20, 30, 10, 'delfin.png', 9, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Demonio De Tasmania', 'Demonio De Tasmania descripción.', 50, 1.00, 10.00, 20, 30, 10, 'demonio_de_tasmania.png', 8, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Dragon Barbudo', 'Dragon Barbudo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'dragon_barbudo.png', 24, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Dragon De Komodo', 'Dragon De Komodo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'dragon_de_komodo.png', 24, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Elefante', 'Elefante descripción.', 50, 1.00, 10.00, 20, 30, 10, 'elefante.png', 7, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Elefante Oriental', 'Elefante Oriental descripción.', 50, 1.00, 10.00, 20, 30, 10, 'elefante_oriental.png', 7, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Erizo', 'Erizo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'erizo.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Flamenco', 'Flamenco descripción.', 50, 1.00, 10.00, 20, 30, 10, 'flamenco.png', 22, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Foca', 'Foca descripción.', 50, 1.00, 10.00, 20, 30, 10, 'foca.png', 14, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Frailecillo', 'Frailecillo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'frailecillo.png', 19, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gacela', 'Gacela descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gacela.png', 10, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gallina', 'Gallina descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gallina.png', 20, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gallo', 'Gallo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gallo.png', 20, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gamba', 'Gamba descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gamba.png', 31, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gato Bangali', 'Gato Bangali descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gato_bangali.png', 1, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gato Comun', 'Gato Comun descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gato_comun.png', 1, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gato Esfingue', 'Gato Esfingue descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gato_esfingue.png', 1, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gato Persa', 'Gato Persa descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gato_persa.png', 1, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gato Siames', 'Gato Siames descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gato_siames.png', 1, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gavial', 'Gavial descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gavial.png', 26, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gaviota', 'Gaviota descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gaviota.png', 19, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gecko Leopardo', 'Gecko Leopardo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gecko_leopardo.png', 24, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Golden-Retriever', 'Golden-Retriever descripción.', 50, 1.00, 10.00, 20, 30, 10, 'golden-retriever.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gorila', 'Gorila descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gorila.png', 3, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Gorrion', 'Gorrion descripción.', 50, 1.00, 10.00, 20, 30, 10, 'gorrion.png', 21, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Grulla', 'Grulla descripción.', 50, 1.00, 10.00, 20, 30, 10, 'grulla.png', 22, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Guepardo', 'Guepardo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'guepardo.png', 1, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Halcon', 'Halcon descripción.', 50, 1.00, 10.00, 20, 30, 10, 'halcon.png', 18, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Hamster', 'Hamster descripción.', 50, 1.00, 10.00, 20, 30, 10, 'hamster.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Hiena', 'Hiena descripción.', 50, 1.00, 10.00, 20, 30, 10, 'hiena.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Hipopotamo', 'Hipopotamo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'hipopotamo.png', 7, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Iguana Verde', 'Iguana Verde descripción.', 50, 1.00, 10.00, 20, 30, 10, 'iguana_verde.png', 24, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Jabali Africano', 'Jabali Africano descripción.', 50, 1.00, 10.00, 20, 30, 10, 'jabali_africano.png', 13, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Jabali Asiatico', 'Jabali Asiatico descripción.', 50, 1.00, 10.00, 20, 30, 10, 'jabali_asiatico.png', 13, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Jabali Europeo', 'Jabali Europeo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'jabali_europeo.png', 13, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Jaguar', 'Jaguar descripción.', 50, 1.00, 10.00, 20, 30, 10, 'jaguar.png', 1, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Jirafa', 'Jirafa descripción.', 50, 1.00, 10.00, 20, 30, 10, 'jirafa.png', 16, 3);

INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Kiwi', 'Kiwi descripción.', 50, 1.00, 10.00, 20, 30, 10, 'kiwi.png', 20, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Koala', 'Koala descripción.', 50, 1.00, 10.00, 20, 30, 10, 'koala.png', 8, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Langosta', 'Langosta descripción.', 50, 1.00, 10.00, 20, 30, 10, 'langosta.png', 31, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Lechuza', 'Lechuza descripción.', 50, 1.00, 10.00, 20, 30, 10, 'lechuza.png', 18, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Lemur', 'Lemur descripción.', 50, 1.00, 10.00, 20, 30, 10, 'lemur.png', 3, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Leon', 'Leon descripción.', 50, 1.00, 10.00, 20, 30, 10, 'leon.png', 1, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Leon Marino', 'Leon Marino descripción.', 50, 1.00, 10.00, 20, 30, 10, 'leon_marino.png', 14, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Leopardo', 'Leopardo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'leopardo.png', 1, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Liebre', 'Liebre descripción.', 50, 1.00, 10.00, 20, 30, 10, 'liebre.png', 6, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Lince', 'Lince descripción.', 50, 1.00, 10.00, 20, 30, 10, 'lince.png', 1, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Llama', 'Llama descripción.', 50, 1.00, 10.00, 20, 30, 10, 'llama.png', 12, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Lobo', 'Lobo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'lobo.png', 2, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Lobo Artico', 'Lobo Artico descripción.', 50, 1.00, 10.00, 20, 30, 10, 'lobo_artico.png', 2, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Mandril', 'Mandril descripción.', 50, 1.00, 10.00, 20, 30, 10, 'mandril.png', 3, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Mantarraya', 'Mantarraya descripción.', 50, 1.00, 10.00, 20, 30, 10, 'mantarraya.png', 29, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Mapache', 'Mapache descripción.', 50, 1.00, 10.00, 20, 30, 10, 'mapache.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Mofeta', 'Mofeta descripción.', 50, 1.00, 10.00, 20, 30, 10, 'mofeta.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Mono', 'Mono descripción.', 50, 1.00, 10.00, 20, 30, 10, 'mono.png', 3, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Morsa', 'Morsa descripción.', 50, 1.00, 10.00, 20, 30, 10, 'morsa.png', 14, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Murcielago', 'Murcielago descripción.', 50, 1.00, 1.00, 20, 30, 10, 'murcielago.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Nutria', 'Nutria descripción.', 50, 1.00, 10.00, 20, 30, 10, 'nutria.png', 14, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Okapi', 'Okapi descripción.', 50, 1.00, 10.00, 20, 30, 10, 'okapi.png', 16, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Orangutan', 'Orangutan descripción.', 50, 1.00, 10.00, 20, 30, 10, 'orangutan.png', 3, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Orca', 'Orca descripción.', 50, 1.00, 10.00, 20, 30, 10, 'orca.png', 9, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Oso Hormiguero', 'Oso Hormiguero descripción.', 50, 1.00, 10.00, 20, 30, 10, 'oso_hormiguero.png', 17, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Oso Negro', 'Oso Negro descripción.', 50, 1.00, 10.00, 20, 30, 10, 'oso_negro.png', 4, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Oso Panda', 'Oso Panda descripción.', 50, 1.00, 10.00, 20, 30, 10, 'oso_panda.png', 4, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Oso Pardo', 'Oso Pardo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'oso_pardo.png', 4, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Oso Perezoso', 'Oso Perezoso descripción.', 50, 1.00, 10.00, 20, 30, 10, 'oso_perezoso.png', 17, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Oso Polar', 'Oso Polar descripción.', 50, 1.00, 10.00, 20, 30, 10, 'oso_polar.png', 4, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Oveja', 'Oveja descripción.', 50, 1.00, 10.00, 20, 30, 10, 'oveja.png', 15, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Paloma', 'Paloma descripción.', 50, 1.00, 10.00, 20, 30, 10, 'paloma.png', 21, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pantera', 'Pantera descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pantera.png', 1, 2);


INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pato Azulon', 'Pato Azulon descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pato_azulon.png', 19, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pato Criollo', 'Pato Criollo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pato_criollo.png', 19, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pavo', 'Pavo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pavo.png', 20, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pavo Real', 'Pavo Real descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pavo_real.png', 20, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pelicano', 'Pelicano descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pelicano.png', 19, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Bulldog', 'Perro Bulldog descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_bulldog.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Bull Terrier', 'Perro Bull Terrier descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_bull_terrier.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Caniche', 'Perro Caniche descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_caniche.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Dalmata', 'Perro Dalmata descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_dalmata.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Doberman', 'Perro Doberman descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_doberman.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Galgo', 'Perro Galgo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_galgo.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Husky', 'Perro Husky descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_husky.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Labrador', 'Perro Labrador descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_labrador.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Pastor Aleman', 'Perro Pastor Aleman descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_pastor_aleman.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Pitbull', 'Perro Pitbull descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_pitbull.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Podenco', 'Perro Podenco descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_podenco.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Rotweiler', 'Perro Rotweiler descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_rotweiler.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Salchicha', 'Perro Salchicha descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_salchicha.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Salvaje Africano', 'Perro Salvaje Africano descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_salvaje_africano.png', 2, 1);


INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Perro Yorkshire', 'Perro Yorkshire descripción.', 50, 1.00, 10.00, 20, 30, 10, 'perro_yorkshire.png', 2, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pez Abisal', 'Pez Abisal descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pez_abisal.png', 29, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pez Anguila', 'Pez Anguila descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pez_anguila.png', 29, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pez Espada', 'Pez Espada descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pez_espada.png', 29, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pez Globo', 'Pez Globo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pez_globo.png', 29, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pez Gota', 'Pez Gota descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pez_gota.png', 29, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pez Payaso', 'Pez Payaso descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pez_payaso.png', 29, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pica Alpina', 'Pica Alpina descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pica_alpina.png', 6, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pinguino Africano', 'Pinguino Africano descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pinguino_africano.png', 19, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pinguino Emperador', 'Pinguino Emperador descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pinguino_emperador.png', 19, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pinguino Rey', 'Pinguino Rey descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pinguino_rey.png', 19, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Piton Reticulada', 'Piton Reticulada descripción.', 50, 1.00, 10.00, 20, 30, 10, 'piton_reticulada.png', 23, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Puerco Espin', 'Puerco Espin descripción.', 50, 1.00, 10.00, 20, 30, 10, 'puerco_espin.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pulpo', 'Pulpo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pulpo.png', 32, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Puma', 'Puma descripción.', 50, 1.00, 10.00, 20, 30, 10, 'puma.png', 1, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Rana Azul', 'Rana Azul descripción.', 50, 1.00, 10.00, 20, 30, 10, 'rana_azul.png', 27, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Rana Comun', 'Rana Comun descripción.', 50, 1.00, 10.00, 20, 30, 10, 'rana_comun.png', 27, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Rana Arborea', 'Rana Arborea descripción.', 50, 1.00, 10.00, 20, 30, 10, 'rana_arborea.png', 27, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Rata', 'Rata descripción.', 50, 1.00, 10.00, 20, 30, 10, 'rata.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Raton', 'Raton descripción.', 50, 1.00, 10.00, 20, 30, 10, 'raton.png', 5, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Reno', 'Reno descripción.', 50, 1.00, 10.00, 20, 30, 10, 'reno.png', 10, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Riniceronte Blanco', 'Riniceronte Blanco descripción.', 50, 1.00, 10.00, 20, 30, 10, 'rinoceronte_blanco.png', 7, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Rinoceronte Negro', 'Rinoceronte Negro descripción.', 50, 1.00, 10.00, 20, 30, 10, 'rinoceronte_negro.png', 7, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Salamandra', 'Salamandra descripción.', 50, 1.00, 10.00, 20, 30, 10, 'salamandra.png', 28, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Salamandra Gigante China', 'Salamandre Gigante China descripción.', 50, 1.00, 10.00, 20, 30, 10, 'salamandra_gigante_china.png', 28, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Salmon', 'Salmon descripción.', 50, 1.00, 10.00, 20, 30, 10, 'salmon.png', 29, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Sapo Toro', 'Sapo Toro descripción.', 50, 1.00, 10.00, 20, 30, 10, 'sapo_toro.png', 27, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Sepia', 'Sepia descripción.', 50, 1.00, 10.00, 20, 30, 10, 'sepia.png', 32, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Serpiente Cascabel', 'Serpiente Cascabel descripción.', 50, 1.00, 10.00, 20, 30, 10, 'serpiente_cascabel.png', 23, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Serpiente Comun', 'Serpiente Comun descripción.', 50, 1.00, 10.00, 20, 30, 10, 'serpiente_comun.png', 23, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Siluro', 'Siluro descripción.', 50, 1.00, 10.00, 20, 30, 10, 'siluro.png', 29, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tiburon Peregrino', 'Tiburon Peregrino descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tiburon peregrino.png', 30, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tiburon Ballena', 'Tiburon Ballena descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tiburon_ballena.png', 30, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tiburon Blanco', 'Tiburon Blanco descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tiburon_blanco.png', 30, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tiburon Duende', 'Tiburon Duende descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tiburon_duende.png', 30, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tiburon Mako', 'Tiburon Mako descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tiburon_mako.png', 30, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tiburon Martillo', 'Tiburon Martillo descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tiburon_martillo.png', 30, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tiburon Tigre', 'Tiburon Tigre descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tiburon_tigre.png', 30, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tiburon Toro', 'Tiburon Toro descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tiburon_toro.png', 30, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tiburon Zorro', 'Tiburon Zorro descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tiburon_zorro.png', 30, 2);


INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tigre', 'Tigre descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tigre.png', 1, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Toro', 'Toro descripción.', 50, 1.00, 10.00, 20, 30, 10, 'toro.png', 11, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tortuga Caiman', 'Tortuga Caiman descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tortuga_caiman.png', 25, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tortuga De Rio', 'Tortuga De Rio descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tortuga_de_rio.png', 25, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tortuga Mapa', 'Tortuga Mapa descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tortuga_mapa.png', 25, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tortuga Marina', 'Tortuga Marina descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tortuga_marina.png', 25, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Tortuga Terrestre', 'Tortuga Terrestre descripción.', 50, 1.00, 10.00, 20, 30, 10, 'tortuga_terrestre.png', 25, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Vaca', 'Vaca descripción.', 50, 1.00, 10.00, 20, 30, 10, 'vaca.png', 11, 3);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Wallaby', 'Wallaby descripción.', 50, 1.00, 10.00, 20, 30, 10, 'wallaby.png', 8, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Zarigueya', 'Zarigueya descripción.', 50, 1.00, 10.00, 20, 30, 10, 'zarigueya.png', 8, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Zebra', 'Zebra descripción.', 50, 1.00, 10.00, 20, 30, 10, 'zebra.png', 12, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Zorro', 'Zorro descripción.', 50, 1.00, 10.00, 20, 30, 10, 'zorro.png', 2, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Zorro Artico', 'Zorro Artico descripción.', 50, 1.00, 10.00, 20, 30, 10, 'zorro_artico.png', 2, 2);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Ñu', 'Ñu descripción.', 50, 1.00, 10.00, 20, 30, 10, 'ñu.png', 10, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Ornitorrinco', 'Ornitorrinco descripción.', 50, 1.00, 10.00, 20, 30, 10, 'ornitorrinco.png', 33, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Equidna', 'Equidna descripción.', 50, 1.00, 10.00, 20, 30, 10, 'equidna.png', 33, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Narval', 'Narval descripción.', 50, 1.00, 10.00, 20, 30, 10, 'narval.png', 9, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Aye-Aye', 'Aye-Aye descripción.', 50, 1.00, 10.00, 20, 30, 10, 'aye_aye.png', 3, 1);
INSERT INTO animals (name, description, inteligence, height, weight, speed, danger, longevity, image, id_subcategory, id_diet) VALUES ('Pangolin', 'Pangolin descripción.', 50, 1.00, 10.00, 20, 30, 10, 'pangolin.png', 17, 1);





INSERT INTO animal_types (id_animal, id_type) VALUES (1,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (2,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (3,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (4,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (5,6);
INSERT INTO animal_types (id_animal, id_type) VALUES (6,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (7,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (8,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (9,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (10,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (11,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (12,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (13,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (14,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (15,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (16,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (17,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (18,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (19,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (20,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (21,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (22,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (23,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (24,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (25,6);
INSERT INTO animal_types (id_animal, id_type) VALUES (26,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (27,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (28,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (29,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (30,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (31,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (32,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (33,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (34,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (35,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (36,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (37,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (38,6);
INSERT INTO animal_types (id_animal, id_type) VALUES (39,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (40,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (41,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (42,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (43,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (44,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (45,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (46,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (47,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (48,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (49,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (50,1);

INSERT INTO animal_types (id_animal, id_type) VALUES (51,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (52,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (53,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (54,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (55,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (56,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (57,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (58,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (59,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (60,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (61,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (62,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (63,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (64,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (65,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (66,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (67,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (68,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (69,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (70,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (71,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (72,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (73,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (74,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (75,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (76,6);
INSERT INTO animal_types (id_animal, id_type) VALUES (77,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (78,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (79,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (80,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (81,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (82,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (83,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (84,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (85,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (86,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (87,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (88,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (89,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (90,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (91,6);
INSERT INTO animal_types (id_animal, id_type) VALUES (92,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (93,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (94,6);
INSERT INTO animal_types (id_animal, id_type) VALUES (95,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (96,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (97,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (98,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (99,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (100,5);

INSERT INTO animal_types (id_animal, id_type) VALUES (101,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (102,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (103,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (104,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (105,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (106,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (107,6);
INSERT INTO animal_types (id_animal, id_type) VALUES (108,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (109,4); 
INSERT INTO animal_types (id_animal, id_type) VALUES (110,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (111,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (112,6);
INSERT INTO animal_types (id_animal, id_type) VALUES (113,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (114,6);
INSERT INTO animal_types (id_animal, id_type) VALUES (115,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (116,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (117,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (118,6);
INSERT INTO animal_types (id_animal, id_type) VALUES (119,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (120,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (121,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (122,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (123,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (124,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (125,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (126,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (127,4);
INSERT INTO animal_types (id_animal, id_type) VALUES (128,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (129,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (130,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (131,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (132,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (133,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (134,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (135,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (136,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (137,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (138,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (139,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (140,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (141,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (142,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (143,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (144,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (145,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (146,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (147,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (148,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (149,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (150,3);

INSERT INTO animal_types (id_animal, id_type) VALUES (151,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (152,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (153,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (154,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (155,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (156,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (157,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (158,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (159,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (160,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (161,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (162,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (163,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (164,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (165,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (166,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (167,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (168,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (169,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (170,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (171,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (172,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (173,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (174,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (175,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (176,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (177,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (178,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (179,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (180,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (181,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (182,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (183,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (184,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (185,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (186,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (187,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (188,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (189,5);
INSERT INTO animal_types (id_animal, id_type) VALUES (190,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (191,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (192,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (193,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (194,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (195,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (196,3);
INSERT INTO animal_types (id_animal, id_type) VALUES (197,1);
INSERT INTO animal_types (id_animal, id_type) VALUES (198,2);
INSERT INTO animal_types (id_animal, id_type) VALUES (199,6);
INSERT INTO animal_types (id_animal, id_type) VALUES (200,1);

-- Usuario admin, la contraseña es -> '123456789Aa$$', (cambiar correo electronico a su gusto)
INSERT INTO users (id,email,username,password) VALUES (1,'tucorreo.com','adminUser','pbkdf2_sha256$1000000$vcbzwKiPbepG7pMGbISKQw$/zR16G1kit9sOf0qtHsqallvt9/NyUXptwASL5USZc4=')


