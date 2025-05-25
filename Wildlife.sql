-- Active: 1748146401771@@127.0.0.1@4185@conservation_db

-- Rangers Table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

-- Species Table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);

-- Sightings Table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(150) NOT NULL,
    species_id INTEGER NOT NULL REFERENCES species (species_id),
    ranger_id INTEGER NOT NULL REFERENCES rangers (ranger_id),
    notes TEXT
);

-- Insert sample data
INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range'),
('David Shore', 'Western Forest'),
('Eva Lin', 'Highland Meadows'),
('Frank Moore', 'Dry Plains');


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Indian Pangolin', 'Manis crassicaudata', '1821-01-01', 'Near Threatened'),
('Golden Langur', 'Trachypithecus geei', '1953-01-01', 'Endangered'),
('Indian Wolf', 'Canis lupus pallipes', '1832-01-01', 'Vulnerable'),
('Ganges River Dolphin', 'Platanista gangetica', '1801-01-01', 'Endangered');


INSERT INTO sightings (sighting_time, location, species_id, ranger_id, notes) VALUES
('2024-05-10 07:45:00', 'Peak Ridge', 1, 1, 'Camera trap image captured'),
('2024-05-12 16:20:00', 'Bankwood Area', 2, 2, 'Juvenile seen'),
('2024-05-15 09:10:00', 'Bamboo Grove East', 3, 3, 'Feeding observed'),
('2024-05-18 18:30:00', 'Snowfall Pass', 1, 2, NULL),
('2024-05-20 06:15:00', 'Forest Edge', 5, 4, 'Tracks found near termite mound'),
('2024-05-22 13:40:00', 'Canopy Zone', 6, 5, 'Spotted in tree with infant'),
('2024-05-25 17:00:00', 'Dry Plains West', 7, 6, 'Howling heard at dusk'),
('2024-05-27 08:30:00', 'River Bend', 8, 1, 'Swimming upstream'),
('2024-05-28 10:25:00', 'Bamboo Grove West', 3, 2, 'Climbing behavior recorded'),
('2024-05-29 19:50:00', 'Savannah Watchpoint', 2, 3, 'Observed with prey');


-- Query all tables
SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;



INSERT INTO rangers (name, region) VALUES
('Derek Fox','Coastal Plains');



SELECT COUNT(DISTINCT species_id) as unique_species_count FROM sightings;


SELECT * FROM sightings WHERE location LIKE '%Pass%';


SELECT r.name, count(s.sighting_id) as total_sightings FROM rangers r LEFT JOIN sightings s ON r.ranger_id = s.ranger_id GROUP BY r.name ORDER BY r.name;



SELECT s.common_name FROM species s LEFT JOIN sightings si ON s.species_id = si.species_id  WHERE si.notes IS NULL;


SELECT r.name, s.common_name, si.sighting_time FROM rangers r JOIN sightings si ON r.ranger_id = si.ranger_id  JOIN species s ON si.species_id = s.species_id ORDER BY si.sighting_time DESC LIMIT 2;




UPDATE species SET conservation_status = 'Historic' WHERE discovery_date < '1800-01-01';




SELECT 
  sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;



DELETE FROM rangers WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);