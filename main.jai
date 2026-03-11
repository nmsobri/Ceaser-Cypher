#import "Basic";
#import "POSIX";

LOWER_CASE_LOWER_BOUND :u8: 97;
LOWER_CASE_UPPER_BOUND :s16: 122;
UPPER_CASE_LOWER_BOUND :u8: 65;
UPPER_CASE_UPPER_BOUND :s16: 90;
SPACE_CHAR :: 32;

main :: () {
	print("Welcome to the Caesar Cipher!\n");

	buffer :[1024]u8;

	print("How many characters to shift? ");
	bytes_read := read(STDIN_FILENO, buffer.data, buffer.count-1);
	shift_count_str := to_string(buffer.data, bytes_read);
	shift_count_str.count -=1; // remove the newline character
	shift_count, ok := string_to_int(shift_count_str);

	if !ok {
		print("Invalid input for shift count. Exiting...\n");
		return;
	}

	print("Enter a string to encrypt: ");
	bytes_read = read(STDIN_FILENO, buffer.data, buffer.count-1);
	input := to_string(buffer.data, bytes_read);
	input.count -=1; // remove the newline character

	// Cypher the input using Caesar cipher
	for ch, i: input {
		if ch >= LOWER_CASE_LOWER_BOUND && ch <= LOWER_CASE_UPPER_BOUND { // lowercase a-z
			input[i] += cast(u8)shift_count;
			offset := input[i] - LOWER_CASE_UPPER_BOUND;

			if offset > 0 {
				input[i] = LOWER_CASE_LOWER_BOUND + (cast(u8)offset - 1);
			}
		} else if ch >= UPPER_CASE_LOWER_BOUND && ch <= UPPER_CASE_UPPER_BOUND {  // uppercase A-Z
			input[i] += cast(u8)shift_count;
			offset := input[i] - UPPER_CASE_UPPER_BOUND;

			if offset > 0 {
				input[i] = UPPER_CASE_LOWER_BOUND + (cast(u8)offset - 1);
			}
		}
	}

	print("Encrypted: %\n", input );
}
