
CREATE TABLE poll_investments (
    user_id VARCHAR(10) NOT NULL,
    poll_id VARCHAR(10) NOT NULL,
    poll_option_id VARCHAR(10) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    created_dt DATE NOT NULL,
    PRIMARY KEY (user_id, poll_id, poll_option_id)
);

-- Insert sample data
INSERT INTO poll_investments (user_id, poll_id, poll_option_id, amount, created_dt) VALUES
('id1', 'p1', 'A', 200, '2021-12-01'),
('id2', 'p1', 'C', 250, '2021-12-01'),
('id3', 'p1', 'A', 200, '2021-12-01'),
('id4', 'p1', 'B', 500, '2021-12-01'),
('id5', 'p1', 'C', 50, '2021-12-01'),
('id6', 'p1', 'D', 500, '2021-12-01'),
('id7', 'p1', 'C', 200, '2021-12-01'),
('id8', 'p1', 'A', 100, '2021-12-01');

-- Calculate Returns
WITH non_winning_total AS (
    SELECT SUM(amount) AS total_non_winning_investment
    FROM poll_investments
    WHERE poll_id = 'p1'
    AND poll_option_id IN ('A', 'B', 'D')
),
winning_total AS (
    SELECT SUM(amount) AS total_winning_investment
    FROM poll_investments
    WHERE poll_id = 'p1'
    AND poll_option_id = 'C'
),
user_investments AS (
    SELECT user_id, amount
    FROM poll_investments
    WHERE poll_id = 'p1'
    AND poll_option_id = 'C'
)
SELECT 
    ui.user_id, 
    ROUND(ui.amount + (ui.amount / wt.total_winning_investment) * nwt.total_non_winning_investment, 2) AS Returns
FROM user_investments ui
CROSS JOIN winning_total wt
CROSS JOIN non_winning_total nwt;
