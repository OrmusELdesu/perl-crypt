# Perl Classical Ciphers Cryptography

a collection of small perl scripts to perform basic encryption and decryption of classical cryptographic ciphers and others.

## Usage
1. `atbash.pl'`
   * `-i <input file>, -o <output file>`
- classical cipher originated from the hebrew alphabet used to encode the Torah or Zohar scriptures in ancient times.

2. `a1z26.pl` 
   * `-i <input file>, -o <output file>`
   * `-e encode, -d decode flags`
- simple numerical cipher which converts the letters of the english alphabet to digits, used by jews in the "gematria" calculation in ancient times.

3. `vigenere.pl`
   * `-i <input file>, -o <output file>`
   * `-e encode, -d decode flags`
   * `-k <keyword>`
- a more advanced form of the "caesar cipher", where each shift is differrent according to the numerical value of the "keyword" provided.
- invented by *Giovan Battista Bellaso* in 1553.
