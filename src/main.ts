import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

const app = createApp(App)
app.config.globalProperties.$api = 'https://6070-156-203-218-141.ngrok-free.app'

app.use(createPinia())
app.use(router)

app.mount('#app')
