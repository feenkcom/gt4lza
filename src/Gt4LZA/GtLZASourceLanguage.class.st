Class {
	#name : #GtLZASourceLanguage,
	#superclass : #FAMIXSourceLanguage,
	#category : #'Gt4LZA-Model'
}

{ #category : #accessing }
GtLZASourceLanguage >> gtParserClass [
	^ YAMLParser
]

{ #category : #'as yet unclassified' }
GtLZASourceLanguage >> gtStylerFor: anEntity [
	| rules |
	(anEntity mooseModel isNil or: [ anEntity containerFiles size ~= 1 ])
		ifTrue: [ ^ super gtStyler ].
	rules := {GtSmaCCNodeStylerRule
				nodeClassName: #SmaCCParseNode
				styleBlock: [ :styler :node :text | 
					node parent
						ifNil: [ anEntity containerFiles first entities
								do: [ :each | 
									self addInspectButtonFor: each in: text.
									self addExpanderFor: each in: text ] ] ]}.
	rules do: [ :each | each continueOnMatch: true ].
	^ (GtCompositeSmaCCASTStyler forParser: self gtParserClass)
		stylers: {self gtParserClass gtStyler.
				(GtSmaCCParserStyler forParser: self gtParserClass) stylerRules: rules}
]
