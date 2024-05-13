%% Matlab Hangman - Christian Dianos a1853694

clear variables % prevent bugs from occuring
%% Program Description
% This program when run will play Hangman. Firstly, user input will be
% obtained on their name and the name of the person being hung and the
% rules of the game will be presented. Then, the user will have 10 tries at
% inputting one character at a time to guess the word. If they guess the
% word, the person being hung is free, if they don't the person being hung
% is (imaginarilly) dead and the user loses.

%% Introduction - Description of Game Section
% The introduction will involve the establishing of the game rules, and
% having the user involved in this process. The code will involve the
% asking and storing of the user's name, the name of the person being
% 'hung' and the rules of the game


%% Explaining Game Rules and Getting User's Details

% Obtaining user's name
userName = input('To begin with, please enter your name here: ', 's');

% Prompting user with a message box to ensure they see the entire intro
% message neatly
% Below is adapted from 
% https://au.mathworks.com/help/matlab/ref/msgbox.html#btv1cej-3

msgbox(["Hello there!";"Welcome to Matlab Hangman.";"";"In " + ...
    "this game I (The Computer) will randomly select a word " + ...
    "and ask for you to guess it one letter at a time.";"";"But " + ...
    "there's a catch! every time you guess a wrong letter, a person " + ...
    "(who you will name later) will be one step closer to being " + ...
    "(imaginarily) hung!";"";"However, if you can guess the " + ...
    "entire word, I (The Computer again) will let him" + ...
    " free";"";"So please, enjoy and press OK/Enter to continue"])


% Obtaining hanging's person name
hangName = input(['Please enter the name of the person' ...
    ' being (imaginarily) hanged here: '], 's');

%% Selecting the Word to be Guessed

%calling function to return the randomly generated word
[wordForGuessing] = generateWord(); 

fprintf("Well %s, it's time to save %s.\n", userName, hangName);
fprintf(2, "I know the word you have to guess. " + ...
    "Do you? Let's play!\n\n"); % use of '\n' to make command window clean
        % idea of making fprintf display a different colour 
        % came from https://au.mathworks.com/matlabcentral/answers/15328-adding-color-in-command-window-output

%% Creating Character Array of the Word for Guessing
%This will create an array of '-' elements equal to amount of elements in 
%the word to be guessed

for i = 1:length(wordForGuessing)
    arrayGuessingWord(i) = '-'; 
end

%% In Game - Description of Game Section
% Here, the user is given 10 tries to input a letter to guess the word that
% has been randomly selected. After each attempt the user will recieve
% feedback such as: the word they have guessed so far, the letters they
% have input, whether they input a number, whether they input two
% characters or one twice. Additionally, they are told the remaining
% attempts they have left.

%% Establishing Variables
nUserGuesses = 0; % establoshing for for loop to prevent later bug occurence
userGuessCorrectly = ""; % establishing to prevent later bug occurence
arrayGuessedLetters = []; % establishing to prevent later bug occurence
nAllowedGuesses = 10;
endGameCheck = 0; % to ensure that win game and 
% lose game screen do not show at same time

for nUserGuesses = 1:nAllowedGuesses
    
    %% Calculating Remaining Guesses and Asking User for Input
    
    % calculating amount of remaining guesses
    nRemainingUserGuesses = (nAllowedGuesses+1) - nUserGuesses; 
    
    if nRemainingUserGuesses == 1
        % displaying the amount of guesses left with correct grammar
        fprintf(2, 'You have %d more guess left\n', nRemainingUserGuesses) 
    else
        % displaying the amount of guesses left
        fprintf('You have %d more guesses left\n', nRemainingUserGuesses) 
    end
    
    letterUserGuess = input("Enter one character you believe is" + ...
        " in the word: ", "s"); % asking user for character input

    %% Checking if the User Input is a Number

    % Idea of using any function to check if string input contains a 
    % number was adapted from https://stackoverflow.com/questions/58979040/check-if-string-contains-any-numbers-in-matlab
    if any(regexp(letterUserGuess, '[0-9]')) == 1 
        fprintf(2, "Hey fool! I told you to enter a CHARACTER, that " + ...
            "was a NUMBER. You lose a try\n")
    end
    
    %% Checking if User Input is More than One Character

    % conditional logic to see if the string input has a length
    % greater than one character
    if length(letterUserGuess) > 1 
        fprintf(2, "You really thought you could cheat like that, " + ...
            "hey %s? WRONG. Only ONE CHARACTER allowed. " + ...
            "You lose a try.\n", userName)
    end

    %% Checking if User Inputs Same Character More Than Once
    
    % using a loop to go through the character array and see if the user
    % input matches with any already input characters
    for i = 1:length(arrayGuessedLetters)
        if arrayGuessedLetters(i) == letterUserGuess
            fprintf(2, "Just to let you know %s, you've already " + ...
                "input %s before. Sorry, you lose a" + ...
                " try.\n", userName, letterUserGuess)
            
            % preventing above message from displaying multiple times if
            % player accidentally inputs same character more than twice
            break
        end
    end

    %% Checking if the User Input Matches with Letter in Word to be 
    %% Guessed AND Matching it in an array
    
    % loop for checking if guessed letter is in word
    for i = 1:length(wordForGuessing) 
        if letterUserGuess == wordForGuessing(i)
            userGuessCorrectly = "yes"; % variable for later if statement
            % updating the array at the position of the letter 
            % to include the matched letter
            arrayGuessingWord(i) = letterUserGuess; 
        end
    end
    
    % if statement to let user know if they guessed correctly or not
    if userGuessCorrectly == "yes" 
        fprintf("Congratulations! You guessed correctly, %c " + ...
            "is in the word\n", letterUserGuess); % showing success message
        userGuessCorrectly = ""; % reset variable
    else
        fprintf("Unlucky friend, incorrect guess\n"); % showing fail message
        userGuessCorrectly = ""; % reset variable
    end

    %% Ending Game Once Word Has Been Guessed

    % checking if the array that displays the word that has been guessed 
    % so far is equal to the array of the word to be guessed
    if arrayGuessingWord == wordForGuessing 
        endGameCheck = 17; % stops game loss/won screen showing together
        fprintf("Well done! You have guessed the word which was ");
        disp(wordForGuessing);
        msgbox(sprintf("CONGRATULATIONS %s!!!!!!! \nYou did it! " + ...
            "What a legend you are. \nDue to your efforts, %s will " + ...
            "no longer be hung\nYou guessed the word (%s) in %d " + ...
            "tries.\nEnjoy your victory %s. You deserve " + ...
            "it.", userName, hangName, wordForGuessing, ...
            nUserGuesses, userName));
            % idea of using sprintf to display variable names in the msgbox
            % came from https://au.mathworks.com/matlabcentral/answers/66261-variables-and-numbers-in-msgbox

        % Making code exit the for loop that is running the guessing
        % character section of the game
        break 
    end

    %% Displaying an Array of the Letters that Have Been Matched So Far
    
    fprintf("The word that you have discovered so far is: ");
    disp(arrayGuessingWord);

    %% Displaying an Array of the Letters that Have Been Guessed So Far
    
    % adding the guessed letter to the end of a character array
    arrayGuessedLetters = [arrayGuessedLetters,letterUserGuess,' ']; 
    fprintf("The letters that you have guessed so far are: ") 
    
    % showing already input letters
    disp(arrayGuessedLetters); 
    fprintf("\n"); % use of '\n' to make game command window more clean


end 

%% End Game - User Loss
if endGameCheck ~= 17 % checking that player still has not guessed word   
    % loading in image for display
    endPhoto = imread("endgame.jpg"); 
    % displaying image before msgbox to ensure that the msgbox is over 
    % image and user sees both at once
    imshow(endPhoto); 
    msgbox(sprintf("Ah, unlucky %s, you didn't guess the word " + ...
        "in time. \nUnfortunately %s will now be (imaginarily) " + ...
        "hung\nThe word you had to guess was '%s'\nYou only poorly " + ...
        "guessed %s. \nUnlucky friend.\n", userName, hangName, ...
        wordForGuessing, arrayGuessingWord));
end

% displaying final game message
disp("Game Over!");