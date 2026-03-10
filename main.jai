#import "Basic";
#import "POSIX";

UPPER_BOUND :s16: 122;
SPACE_CHAR :: 32;
START_CHAR :u8: 97;

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

	// Cypher the input using a simple Caesar cipher with a shift of 1 for now
	for ch, i: input {
		if ch == SPACE_CHAR continue;

		input[i] += cast(u8)shift_count;
		offset := input[i] - UPPER_BOUND;

		if offset > 0 {
			input[i] = START_CHAR + (cast(u8)offset - 1); // wrap around to first character if it goes past 'z'
		}
	}

	print("Encrypted: %\n", input );
}