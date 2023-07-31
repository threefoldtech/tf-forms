import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

const $api = 'https://formsapi.gent01.qa.grid.tf'

const app = createApp(App)
app.config.globalProperties.$api = $api
app.provide('$globals', { $api })

app.use(createPinia())
app.use(router)

app.mount('#app')
