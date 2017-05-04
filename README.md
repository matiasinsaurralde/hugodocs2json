hugodocs2json
==

## Requirements

* **nokogiri:** `gem install nokogiri`

## Sample usage

Clone this repository:

```
$ git clone https://github.com/matiasinsaurralde/hugodocs2json.git
$ cd hugodocs2json
```

Generate your Hugo docs:

```
$ hugo -s ~/docs -d ~/docs-output
```

Run the script, using the output directory as the first argument:
```
$ ruby hugodocs2json.rb ~/docs-output
```

The output will be available as `output.json` in the current working directory.