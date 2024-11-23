class_name RunInitialization
extends Resource

enum Type {
	NEW_RUN,
	CONTINUED_RUN,
}

@export var character: CharacterStats
@export var type: Type
