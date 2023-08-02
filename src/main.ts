import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

const $api = 'http://[300:170b:469a:2ed8:d430:7f8e:5759:f862]:8080'

const app = createApp(App)
app.config.globalProperties.$api = $api
app.provide('$globals', { $api })

app.use(createPinia())
app.use(router)

app.mount('#app')
