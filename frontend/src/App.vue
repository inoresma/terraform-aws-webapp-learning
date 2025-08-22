<template>
  <div id="app">
    <header>
      <h1>Gestor de Notas</h1>
    </header>
    
    <main>
      <NoteForm @note-created="loadNotes" />
      <NoteList 
        :notes="notes" 
        @note-deleted="loadNotes"
        @note-updated="loadNotes"
      />
    </main>
  </div>
</template>

<script>
import NoteForm from './components/NoteForm.vue'
import NoteList from './components/NoteList.vue'
import { notesApi } from './services/api'

export default {
  name: 'App',
  components: {
    NoteForm,
    NoteList
  },
  data() {
    return {
      notes: []
    }
  },
  async mounted() {
    await this.loadNotes()
  },
  methods: {
    async loadNotes() {
      try {
        const response = await notesApi.getNotes()
        this.notes = response.data.results
      } catch (error) {
        console.error('Error cargando notas:', error)
      }
    }
  }
}
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  color: #333;
}

#app {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

header {
  text-align: center;
  margin-bottom: 30px;
}

header h1 {
  color: white;
  font-size: 2.5rem;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

main {
  display: grid;
  grid-template-columns: 1fr 2fr;
  gap: 30px;
}

@media (max-width: 768px) {
  main {
    grid-template-columns: 1fr;
  }
}
</style> 