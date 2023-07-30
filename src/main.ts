import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

const $api = 'https://e68f-156-203-159-109.ngrok-free.app'

const app = createApp(App)
app.config.globalProperties.$api = $api
app.provide('$globals', { $api })

app.use(createPinia())
app.use(router)

app.mount('#app')
