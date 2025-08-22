from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import Note
from .serializers import NoteSerializer


class NoteViewSet(viewsets.ModelViewSet):
    queryset = Note.objects.all()
    serializer_class = NoteSerializer

    @action(detail=False, methods=['get'])
    def important(self, request):
        important_notes = Note.objects.filter(is_important=True)
        serializer = self.get_serializer(important_notes, many=True)
        return Response(serializer.data) 