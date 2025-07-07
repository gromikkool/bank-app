INSERT INTO person.countries (name, alpha2, alpha3, status)
VALUES
    ('Poland',        'PL', 'POL', 'active'),
    ('Germany',       'DE', 'DEU', 'active'),
    ('France',        'FR', 'FRA', 'active'),
    ('Spain',         'ES', 'ESP', 'active'),
    ('Italy',         'IT', 'ITA', 'active'),
    ('Netherlands',   'NL', 'NLD', 'active'),
    ('United States', 'US', 'USA', 'active'),
    ('Canada',        'CA', 'CAN', 'active'),
    ('Brazil',        'BR', 'BRA', 'inactive'),
    ('Japan',         'JP', 'JPN', 'active');

INSERT INTO person.addresses (created, updated, country_id, address, zip_code, archived, city, state)
VALUES
    (NOW(), NOW(), 1, 'ul. Marszałkowska 1',       '00-001', NOW(), 'Warsaw',       'Mazowieckie'),
    (NOW(), NOW(), 2, 'Unter den Linden 5',        '10117',  NOW(), 'Berlin',       'Berlin'),
    (NOW(), NOW(), 3, '10 Rue de Rivoli',          '75001',  NOW(), 'Paris',        'Île-de-France'),
    (NOW(), NOW(), 4, 'Calle de Alcalá 45',        '28014',  NOW(), 'Madrid',       'Community of Madrid'),
    (NOW(), NOW(), 5, 'Via del Corso 22',          '00187',  NOW(), 'Rome',         'Lazio'),
    (NOW(), NOW(), 6, 'Damrak 1-5',                '1012',   NOW(), 'Amsterdam',    'North Holland'),
    (NOW(), NOW(), 7, '1600 Pennsylvania Avenue',  '20500',  NOW(), 'Washington',   'DC'),
    (NOW(), NOW(), 8, '24 Sussex Drive',           'K1M1M4', NOW(), 'Ottawa',       'Ontario'),
    (NOW(), NOW(), 9, 'Av. Paulista 1578',         '01310',  NOW(), 'São Paulo',    'São Paulo'),
    (NOW(), NOW(),10, '1-1 Chiyoda',               '100-8111', NOW(), 'Tokyo',      'Tokyo');
