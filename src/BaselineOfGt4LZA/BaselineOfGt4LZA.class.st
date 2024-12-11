Class {
	#name : #BaselineOfGt4LZA,
	#superclass : #BaselineOf,
	#category : #BaselineOfGt4LZA
}

{ #category : #'as yet unclassified' }
BaselineOfGt4LZA class >> loadLepiter [
	IceRepository registry
		detect: [ :aRepository | aRepository name = 'gt4lza' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties
				addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [ self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGt4LZA >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Gt4LZA'
		]
]
