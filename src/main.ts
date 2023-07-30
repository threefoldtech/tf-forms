import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

const $api = 'http://[304:c141:b69a:3d60:8094:d1b1:563b:986]:8080'

const app = createApp(App)
app.config.globalProperties.$api = $api
app.provide('$globals', { $api })

app.use(createPinia())
app.use(router)

app.mount('#app')
