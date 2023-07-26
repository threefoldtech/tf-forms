<template>
  <form ref="form">
    <slot :props="{ current }"></slot>
  </form>
</template>

<script lang="ts">
import { inject, onMounted, onUnmounted, provide, ref, type Ref } from 'vue'

const KEY = 'form:manager'
export function useFormManager(): FormManagerService | null {
  return inject(KEY, null)
}

export interface FormManagerService {
  current: Ref<number>
}

export default {
  name: 'FormManager',
  props: {
    hx: { type: Object, default: () => ({}) },
    data: { type: Object, required: true }
  },
  setup(props) {
    const current = ref(0)
    provide(KEY, { current } as FormManagerService)

    const form = ref<HTMLFormElement | null>(null)

    const fn = (evt: any) => {
      evt.detail.parameters = props.data
    }

    onUnmounted(() => document.body.removeEventListener('htmx:configRequest', fn))
    onMounted(async () => {
      const f = form.value!
      for (const key in props.hx) f.setAttribute(`hx-${key}`, props.hx[key])

      const $w = window as any
      $w.htmx.process(f)

      document.body.addEventListener('htmx:configRequest', fn)
    })

    return { current, form }
  }
}
</script>
