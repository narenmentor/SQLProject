#Final Project

use finalproject;

-- Create Teams Table
CREATE TABLE Teams (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(50) NOT NULL
);

-- Create Players Table
CREATE TABLE Players (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    player_name VARCHAR(50) NOT NULL,
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

-- Create Matches Table
CREATE TABLE Matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    match_date DATE,
    team1_id INT,
    team2_id INT,
    team1_runs INT,
    team2_runs INT,
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id)
);

-- Create Player_Stats Table
CREATE TABLE Player_Stats (
    stat_id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT,
    player_id INT,
    runs_scored INT,
    wickets_taken INT,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

-- Insert data into Teams Table
INSERT INTO Teams (team_name) VALUES
('Mumbai Indians'),
('Chennai Super Kings'),
('Royal Challengers Bangalore'),
('Kolkata Knight Riders');

-- Insert data into Players Table
INSERT INTO Players (player_name, team_id) VALUES
('Rohit Sharma', 1),
('MS Dhoni', 2),
('Virat Kohli', 3),
('Andre Russell', 4);

-- Insert data into Matches Table
INSERT INTO Matches (match_date, team1_id, team2_id, team1_runs, team2_runs) VALUES
('2023-04-01', 1, 2, 180, 170),
('2023-04-02', 3, 4, 200, 190);

-- Insert data into Player_Stats Table
INSERT INTO Player_Stats (match_id, player_id, runs_scored, wickets_taken) VALUES
(1, 1, 70, 0),
(1, 2, 60, 0),
(2, 3, 90, 0),
(2, 4, 80, 1);

use codexdb;

-- Create Teams table
CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL
);

-- Create Players table
CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(50) NOT NULL,
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

-- Create Matches table
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    match_date DATE NOT NULL,
    home_team_id INT,
    away_team_id INT,
    winner_team_id INT,
    FOREIGN KEY (home_team_id) REFERENCES Teams(team_id),
    FOREIGN KEY (away_team_id) REFERENCES Teams(team_id),
    FOREIGN KEY (winner_team_id) REFERENCES Teams(team_id)
);

-- Create Player_Statistics table
CREATE TABLE Player_Statistics (
    stat_id INT PRIMARY KEY,
    match_id INT,
    player_id INT,
    runs INT,
    wickets INT,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

-- Insert data into Teams table
INSERT INTO Teams (team_id, team_name) VALUES
(1, 'Mumbai Indians'),
(2, 'Chennai Super Kings'),
(3, 'Kolkata Knight Riders'),
(4, 'Royal Challengers Bangalore');

-- Insert data into Players table
INSERT INTO Players (player_id, player_name, team_id) VALUES
(1, 'Rohit Sharma', 1),
(2, 'MS Dhoni', 2),
(3, 'Virat Kohli', 4),
(4, 'Andre Russell', 3),
(5, 'Jasprit Bumrah', 1),
(6, 'Faf du Plessis', 2);

-- Insert data into Matches table
INSERT INTO Matches (match_id, match_date, home_team_id, away_team_id, winner_team_id) VALUES
(1, '2023-04-01', 1, 2, 1),
(2, '2023-04-02', 3, 4, 4),
(3, '2023-04-03', 2, 1, 2),
(4, '2023-04-04', 4, 3, NULL);

-- Insert data into Player_Statistics table
INSERT INTO Player_Statistics (stat_id, match_id, player_id, runs, wickets) VALUES
(1, 1, 1, 56, 0),
(2, 1, 2, 32, 1),
(3, 2, 3, 78, 0),
(4, 2, 4, 45, 2),
(5, 3, 6, 62, 0),
(6, 3, 5, 15, 3);


# List all teams and the total number of matches they have played either as home or away team.

SELECT t.team_name, COUNT(m.match_id) AS total_matches
FROM Teams t
LEFT JOIN Matches m ON t.team_id = m.home_team_id OR t.team_id = m.away_team_id
GROUP BY t.team_name;


#List all matches along with the home and away team names.
SELECT m.match_id, m.match_date, ht.team_name AS home_team, at.team_name AS away_team
FROM Matches m
INNER JOIN Teams ht ON m.home_team_id = ht.team_id
INNER JOIN Teams at ON m.away_team_id = at.team_id;


#Find all players and their statistics in a particular match

SELECT ps.match_id, p.player_name, ps.runs, ps.wickets
FROM Player_Statistics ps
INNER JOIN Players p ON ps.player_id = p.player_id
WHERE ps.match_id = 1;

#Find the winning team for each match along with the match details.

SELECT m.match_id, m.match_date, t.team_name AS winner_team
FROM Matches m
LEFT JOIN Teams t ON m.winner_team_id = t.team_id;



