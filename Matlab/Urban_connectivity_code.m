% Compare Albuquerque's walkability to other U.S. cities
% Author: ChatGPT (GPT-5)
% Date: 2025-11-11

% Load the dataset
data = readtable('urban_connectivity.csv');

% Focus on relevant columns
cities = data.City;
states = data.State;
walk = data.("WalkScore");
transit = data.("TransitScore");
bike = data.("BikeScore");

% Identify Albuquerque (New Mexico)
isABQ = strcmpi(cities, 'Albuquerque') & strcmpi(states, 'NM');

% Check if Albuquerque is found
if ~any(isABQ)
    error('Albuquerque, NM not found in dataset.');
end

% Extract Albuquerque’s scores
abq_walk = walk(isABQ);
abq_transit = transit(isABQ);
abq_bike = bike(isABQ);

% Calculate averages for all other cities
other_walk = mean(walk(~isABQ), 'omitnan');
other_transit = mean(transit(~isABQ), 'omitnan');
other_bike = mean(bike(~isABQ), 'omitnan');

% Combine data for plotting
categories = {'Walk Score', 'Transit Score', 'Bike Score'};
abq_scores = [abq_walk, abq_transit, abq_bike];
other_scores = [other_walk, other_transit, other_bike];

% Create bar chart
figure;
bar([abq_scores; other_scores]')
set(gca, 'XTickLabel', categories)
legend({'Albuquerque, NM', 'Average of Other Cities'}, 'Location', 'northoutside')
title('Walkability Comparison: Albuquerque vs. Other U.S. Cities')
ylabel('Score')
grid on
ylim([0 100])

% Display numeric comparison
fprintf('Albuquerque vs. Average Walkability:\n');
fprintf('  Walk Score   : %.1f (Albuquerque) vs. %.1f (Others)\n', abq_walk, other_walk);
fprintf('  Transit Score: %.1f (Albuquerque) vs. %.1f (Others)\n', abq_transit, other_transit);
fprintf('  Bike Score   : %.1f (Albuquerque) vs. %.1f (Others)\n', abq_bike, other_bike);
