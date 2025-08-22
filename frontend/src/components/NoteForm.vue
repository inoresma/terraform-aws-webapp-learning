<template>
  <div class="note-form">
    <h2>Nueva Nota</h2>
    <form @submit.prevent="createNote">
      <div class="form-group">
        <label for="title">Título:</label>
        <input 
          type="text" 
          id="title" 
          v-model="form.title" 
          required
          placeholder="Título de la nota"
        >
      </div>
      
      <div class="form-group">
        <label for="content">Contenido:</label>
        <textarea 
          id="content" 
          v-model="form.content" 
          required
          placeholder="Contenido de la nota"
          rows="6"
        ></textarea>
      </div>
      
      <div class="form-group checkbox">
        <label>
          <input 
            type="checkbox" 
            v-model="form.is_important"
          >
          Marcar como importante
        </label>
      </div>
      
      <button type="submit" :disabled="loading">
        {{ loading ? 'Creando...' : 'Crear Nota' }}
      </button>
    </form>
  </div>
</template>

<script>
import { notesApi } from '../services/api'

export default {
  name: 'NoteForm',
  data() {
    return {
      form: {
        title: '',
        content: '',
        is_important: false
      },
      loading: false
    }
  },
  methods: {
    async createNote() {
      this.loading = true
      try {
        await notesApi.createNote(this.form)
        this.$emit('note-created')
        this.resetForm()
      } catch (error) {
        console.error('Error creando nota:', error)
        alert('Error al crear la nota')
      } finally {
        this.loading = false
      }
    },
    resetForm() {
      this.form = {
        title: '',
        content: '',
        is_important: false
      }
    }
  }
}
</script>

<style scoped>
.note-form {
  background: white;
  padding: 25px;
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(0,0,0,0.1);
  backdrop-filter: blur(10px);
}

.note-form h2 {
  margin-bottom: 20px;
  color: #333;
  font-size: 1.5rem;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  font-weight: 600;
  color: #555;
}

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 12px;
  border: 2px solid #e1e5e9;
  border-radius: 8px;
  font-size: 14px;
  transition: border-color 0.3s ease;
}

.form-group input:focus,
.form-group textarea:focus {
  outline: none;
  border-color: #667eea;
}

.checkbox {
  display: flex;
  align-items: center;
}

.checkbox label {
  display: flex;
  align-items: center;
  margin-bottom: 0;
  cursor: pointer;
}

.checkbox input[type="checkbox"] {
  width: auto;
  margin-right: 10px;
}

button {
  width: 100%;
  padding: 12px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: transform 0.2s ease;
}

button:hover:not(:disabled) {
  transform: translateY(-2px);
}

button:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}
</style> 