CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

-- Projects Table
CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    repo_url VARCHAR(255),
    domain_name VARCHAR(255),
    is_vibe_coded BOOLEAN DEFAULT FALSE,
    image_url VARCHAR(255),
    tech_stack JSON,
    priority INT DEFAULT 0 -- 1, 2, 3 for homepage slider
);

-- Media Picks Table
CREATE TABLE IF NOT EXISTS media_picks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category ENUM('movie', 'show', 'anime', 'music') NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    best_pick BOOLEAN DEFAULT FALSE,
    image_url VARCHAR(255)
);

-- Certifications Table
CREATE TABLE IF NOT EXISTS certifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    issuer VARCHAR(255),
    issue_date DATE,
    link VARCHAR(255),
    image_url VARCHAR(255)
);

-- Social Links Table
CREATE TABLE IF NOT EXISTS social_links (
    id INT AUTO_INCREMENT PRIMARY KEY,
    platform VARCHAR(100) NOT NULL,
    url VARCHAR(255) NOT NULL,
    icon VARCHAR(100)
);

-- Media Categories Table
CREATE TABLE IF NOT EXISTS media_categories (
    slug VARCHAR(50) PRIMARY KEY,
    label VARCHAR(100) NOT NULL,
    icon VARCHAR(50) NOT NULL,
    background VARCHAR(255) NOT NULL,
    tagline VARCHAR(255),
    sort_order INT DEFAULT 0
);

-- Insert initial data
INSERT INTO projects (name, description, repo_url, domain_name, is_vibe_coded, tech_stack, priority) VALUES 
('Inception', 'Docker-based microservices architecture utilizing NGINX, WordPress, and MariaDB.', 'https://github.com/ouvled86/Inception', '<login>.42.fr', FALSE, '["Docker", "NGINX", "MariaDB", "WordPress"]', 1),
('Caftany Store App', 'Premium ecommerce platform for a boutique brand. Built with a focus on seamless user experience.', 'https://github.com/ouvled86/EleganceWebapp', 'caftany.shop', TRUE, '["React", "Node.js", "Appwrite", "Tailwind"]', 2),
('webserv', 'Lightweight HTTP server implementation in C++98.', 'https://github.com/ouvled86/webserv', NULL, FALSE, '["C++", "C++98", "Sockets"]', 3);

INSERT INTO media_categories (slug, label, icon, background, tagline, sort_order) VALUES
('movie', 'Movies', 'bx-film', 'rgba(237, 28, 36, 0.15)', 'Explore my favorites', 1),
('show', 'TV Shows', 'bx-tv', 'rgba(184, 0, 12, 0.2)', 'Explore my favorites', 2),
('anime', 'Anime', 'bx-ghost', 'rgba(255, 49, 49, 0.15)', 'Explore my favorites', 3),
('music', 'Music', 'bx-music', 'rgba(139, 0, 0, 0.2)', 'Explore my favorites', 4);
