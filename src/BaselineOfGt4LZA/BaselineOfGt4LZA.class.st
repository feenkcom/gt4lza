Class {
	#name : #BaselineOfGt4LZA,
	#superclass : #BaselineOf,
	#category : #BaselineOfGt4LZA
}

{ #category : #baseline }
BaselineOfGt4LZA >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Gt4LZA'
		]
]
