# Marvel-Universe-Directory
Display's a list of Marvel Characters
Navigate to a Detail view were an image and a description are shown

# Set up
go into developer.marvel.com and log in or create an account
get a `public` and `private` key

in `Security` folder create a `.plist` file named `security.plist` and add a key `privateKey` and with the value of your private key

in `Secrity.swift` replace the `apiKey` property with your own `publicKey` from Marvel.
