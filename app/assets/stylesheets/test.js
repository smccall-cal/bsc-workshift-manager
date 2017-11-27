//Find the largest Palindrome in a string


//Example {'sdshdjshracecarsdh'} =  racecar
//Example {'sdihflaradarsdhracecar'} = racecar

//basic
  //iterate thorugh the entire
  //find the next S there is, if there is, keep track of index and check if its a palindrome
  //store the string length of it
  //if there is one palindrome with a higher string length, then you store that palindrome instead

//'qweradarsd'
//'dsradarewq'

var findLargestPalindrome = function (string) {
  var splittedString = string.split('');
  var currentString;
  var currentLargestLength = 0;
  var solution;

  for (var i = 0; i < string.length; i++) {
    var letter = splittedString[i];

    for(var j = 1; j < string.length; j ++) {
      if(string[j] === letter) {
        currentString = splittedString.slice(i, j + 1);
        if(isPalindrome(currentString)){
          if(currentString.length > currentLargestLength) {
            solution = currentString.join('');
            currentLargestLength = solution.length;
          }
        }
      }
    }
  }
  return solution;
}


var isPalindrome = function(splitted) {
  var backPointer = splitted.length;
  for(var i = 0; i < splitted.length; i ++) {
    if(splitted[i] !== splitted[backPointer - 1]) {
      return false;
    }
    backPointer -= 1;
  }
  return true;
}

console.log(findLargestPalindrome('s'));

var findLargestPalindromeFaster = function(string) {
  var splitted = string.split('');
  var currentString;
  var currentLargestLength = 0;
  var solution;

  if(splitted[0] === splitted[1]) {
    currentString = splitted[0] + splitted[1];
    currentLargestLength = 2;
  }

  for(var i = 2; i < splitted.length; i ++) {
    var j = i
    var k = i;
    var current = splitted[i];
    while(splitted[k + 1] === splitted[j - 1] && ( splitted[k + 1] !== undefined && splitted[j - 1] !== undefined)) {
      current = (splitted[k + 1]) + current + splitted[j - 1];
      solution = current;
      k += 1;
      j -= 1;
      console.log(k, j);
    }
  }
}

// console.log(findLargestPalindromeFaster('racecar'));