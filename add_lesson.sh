#!/bin/bash

# Script pour ajouter facilement de nouvelles leçons à all_lessons.dart
# Usage: ./add_lesson.sh <module_id> <lesson_number> <title> <content>

if [ $# -ne 4 ]; then
    echo "Usage: $0 <module_id> <lesson_number> <title> <content>"
    echo "Example: $0 m01_phonetique 4 'Nouveaux sons' 'Contenu de la leçon'"
    exit 1
fi

MODULE_ID=$1
LESSON_NUM=$2
TITLE=$3
CONTENT=$4

# Générer l'ID de la leçon
LESSON_ID="${MODULE_ID}_l${LESSON_NUM}"

# Créer la nouvelle leçon
NEW_LESSON="    Lesson(
      id: '$LESSON_ID',
      moduleId: '$MODULE_ID',
      title: '$TITLE',
      type: 'reading',
      content: '$CONTENT',
      order: $LESSON_NUM,
      audioUrl: '',
    ),"

echo "Ajout de la leçon : $LESSON_ID"
echo "Contenu à ajouter :"
echo "$NEW_LESSON"

# Note: Pour utiliser ce script, il faudrait l'intégrer avec sed ou awk pour insérer dans le fichier
echo "Pour l'instant, copiez-collez ce contenu dans le fichier all_lessons.dart dans la section appropriée."