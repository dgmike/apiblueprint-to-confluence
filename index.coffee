#!/usr/bin/env coffee

fs = require "fs"
aglio = require "aglio"
Remarkable = require "remarkable"

file = "#{process.cwd()}/#{process.argv[2]}"
blueprint = fs.readFileSync(file).toString()

highlight = (content) ->
    """<ac:structured-macro ac:name="code"><ac:parameter ac:name="title">Headers</ac:parameter><ac:plain-text-body><![CDATA[#{content}]]></ac:plain-text-body></ac:structured-macro>"""

md = new Remarkable 'full', { html: true, linkify: true, typographer: true, highlight }

options =
    includePath: process.cwd()
    template: "#{__dirname}/template.jade"
    locals: {
        highlight: highlight,
        markdown: (content) ->
            md.render content
    }

aglio.render blueprint, options, (err, html, warnings) ->
    if err
    	return console.log "ERRO: #{err.message}"
    console.log html
