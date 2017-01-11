# Satis

Custom static [Composer](https://getcomposer.org/) repository generated with [Satis](https://github.com/composer/satis).


## Installation

List of Git repositories provided by Satis is contained in a JSON [configuration](system/satis.json) file.

## Usage

Clone the project and then install the actual Satis engine required for building the index:

	git clone https://github.com/Unit6/satis.git
	cd satis
	make install
	
That will build files in a `public` directory. You will need to copy the built files to the root directory:

	make copy
	
Create a new commit and push the changes to GitHub:

	git commit -am "Added new package FooBar."
	git push origin master
	