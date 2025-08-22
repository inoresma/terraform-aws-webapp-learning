import axios from 'axios'


const API_BASE_URL = import.meta.env.VITE_API_URL

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
})

export const notesApi = {
  getNotes() {
    return api.get('/notes/')
  },

  getNote(id) {
    return api.get(`/notes/${id}/`)
  },

  createNote(noteData) {
    return api.post('/notes/', noteData)
  },

  updateNote(id, noteData) {
    return api.put(`/notes/${id}/`, noteData)
  },

  deleteNote(id) {
    return api.delete(`/notes/${id}/`)
  },

  getImportantNotes() {
    return api.get('/notes/important/')
  }
} 