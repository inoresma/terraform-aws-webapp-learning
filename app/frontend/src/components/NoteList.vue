<template>
  <div class="note-list">
    <h2>Mis Notas ({{ notes.length }})</h2>
    
    <div v-if="notes.length === 0" class="empty-state">
      <p>No hay notas aún. ¡Crea tu primera nota!</p>
    </div>
    
    <div v-else class="notes-grid">
      <NoteCard 
        v-for="note in notes" 
        :key="note.id" 
        :note="note"
        @note-deleted="$emit('note-deleted')"
        @note-updated="$emit('note-updated')"
      />
    </div>
  </div>
</template>

<script>
import NoteCard from './NoteCard.vue'

export default {
  name: 'NoteList',
  components: {
    NoteCard
  },
  props: {
    notes: {
      type: Array,
      required: true
    }
  }
}
</script>

<style scoped>
.note-list {
  background: white;
  padding: 25px;
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(0,0,0,0.1);
  backdrop-filter: blur(10px);
}

.note-list h2 {
  margin-bottom: 20px;
  color: #333;
  font-size: 1.5rem;
}

.empty-state {
  text-align: center;
  padding: 40px 20px;
  color: #666;
}

.empty-state p {
  font-size: 1.1rem;
}

.notes-grid {
  display: grid;
  gap: 20px;
}

@media (min-width: 768px) {
  .notes-grid {
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  }
}
</style> 