import './App.css'
import React from 'react'   
import { Formulario as RawFormulario } from './components/formulario/formulario'

const Formulario = RawFormulario as unknown as React.FC

function App() {  
  return (
    <div>
      <Formulario />
    </div>
  );
}

export default App
