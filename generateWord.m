%% Selecting the Word to be Guessed

function [word_For_Guessing] = generateWord() % want to have function return the word for guessing
% randomly select a word from a vector for user to guess
% Word array where the words for the game are being stored
guessing_Word_Vector = ["giraffe", "unicorn", "alphabet", "solution", "character", "delete", "savagely", "bottle", "container", "different"];
% Generating an integer that corresponds with the element of the vector
% that the user will have to guess
word_For_Guessing = char(guessing_Word_Vector(randi(10))); % Converting word to character vector to ensure individual characters can be accessed for future code
end 
