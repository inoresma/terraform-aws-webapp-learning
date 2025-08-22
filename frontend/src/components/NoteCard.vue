<template>
  <div class="note-card" :class="{ important: note.is_important }">
    <div class="note-header">
      <h3>{{ note.title }}</h3>
      <div class="note-actions">
        <button @click="toggleEdit" class="btn-edit">
          {{ isEditing ? 'Cancelar' : 'Editar' }}
        </button>
        <button @click="deleteNote" class="btn-delete">Eliminar</button>
      </div>
    </div>
    
    <div v-if="!isEditing" class="note-content">
      <p>{{ note.content }}</p>
      <div class="note-meta">
        <span class="date">{{ formatDate(note.updated_at) }}</span>
        <span v-if="note.is_important" class="important-badge">⭐ Importante</span>
      </div>
    </div>
    
    <div v-else class="note-edit">
      <input 
        v-model="editForm.title" 
        type="text" 
        placeholder="Título"
        class="edit-title"
      >
      <textarea 
        v-model="editForm.content" 
        placeholder="Contenido"
        class="edit-content"
        rows="4"
      ></textarea>
      <div class="edit-actions">
        <label class="checkbox">
          <input 
            type="checkbox" 
            v-model="editForm.is_important"
          >
          Importante
        </label>
        <button @click="saveNote" :disabled="saving" class="btn-save">
          {{ saving ? 'Guardando...' : 'Guardar' }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { notesApi } from '../services/api'

export default {
  name: 'NoteCard',
  props: {
    note: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      isEditing: false,
      saving: false,
      editForm: {
        title: '',
        content: '',
        is_important: false
      }
    }
  },
  methods: {
    formatDate(dateString) {
      return new Date(dateString).toLocaleDateString('es-ES', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
      })
    },
    toggleEdit() {
      if (this.isEditing) {
        this.isEditing = false
      } else {
        this.editForm = {
          title: this.note.title,
          content: this.note.content,
          is_important: this.note.is_important
        }
        this.isEditing = true
      }
    },
    async saveNote() {
      this.saving = true
      try {
        await notesApi.updateNote(this.note.id, this.editForm)
        this.isEditing = false
        this.$emit('note-updated')
      } catch (error) {
        console.error('Error actualizando nota:', error)
        alert('Error al actualizar la nota')
      } finally {
        this.saving = false
      }
    },
    async deleteNote() {
      if (confirm('¿Estás seguro de que quieres eliminar esta nota?')) {
        try {
          await notesApi.deleteNote(this.note.id)
          this.$emit('note-deleted')
        } catch (error) {
          console.error('Error eliminando nota:', error)
          alert('Error al eliminar la nota')
        }
      }
    }
  }
}
</script>

<style scoped>
.note-card {
  background: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 8px;
  padding: 20px;
  transition: all 0.3s ease;
}

.note-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.note-card.important {
  border-left: 4px solid #ffc107;
  background: #fffbf0;
}

.note-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 15px;
}

.note-header h3 {
  margin: 0;
  color: #333;
  font-size: 1.2rem;
  flex: 1;
}

.note-actions {
  display: flex;
  gap: 8px;
}

.btn-edit,
.btn-delete {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  font-size: 12px;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.btn-edit {
  background: #007bff;
  color: white;
}

.btn-edit:hover {
  background: #0056b3;
}

.btn-delete {
  background: #dc3545;
  color: white;
}

.btn-delete:hover {
  background: #c82333;
}

.note-content p {
  margin: 0 0 15px 0;
  line-height: 1.6;
  color: #555;
}

.note-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 12px;
  color: #666;
}

.important-badge {
  color: #856404;
  font-weight: 600;
}

.note-edit {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.edit-title {
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
}

.edit-content {
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  resize: vertical;
}

.edit-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.checkbox {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
}

.btn-save {
  padding: 8px 16px;
  background: #28a745;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.btn-save:hover:not(:disabled) {
  background: #218838;
}

.btn-save:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}
</style> 