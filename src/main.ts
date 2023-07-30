import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

const app = createApp(App)
app.config.globalProperties.$api = 'https://e68f-156-203-159-109.ngrok-free.app'

app.use(createPinia())
app.use(router)

app.mount('#app')
