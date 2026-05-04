Class {
	#name : 'BaselineOfGt4LZA',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGt4LZA',
	#package : 'BaselineOfGt4LZA'
}

{ #category : 'as yet unclassified' }
BaselineOfGt4LZA class >> loadLepiter [
	IceRepository registry
		detect: [ :aRepository | aRepository name = 'gt4lza' ]
		ifFound: [ :aRepository | 
			LeDatabasesRegistry defaultLogicalDatabase
				addKnowledgebaseFromDirectory: 
				aRepository repositoryDirectory / 'lepiter' ]
		ifNone: [ self inform: 'Repository not found' ]
]

{ #category : 'baseline' }
BaselineOfGt4LZA >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Gt4LZA'
		]
]
