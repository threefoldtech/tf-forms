<template>
  <form>
    <slot :props="{ current }"></slot>
  </form>
</template>

<script lang="ts">
import { inject, provide, ref, type Ref } from 'vue'

const KEY = 'form:manager'
export function useFormManager(): FormManagerService | null {
  return inject(KEY, null)
}

export interface FormManagerService {
  current: Ref<number>
}

export default {
  name: 'FormManager',
  setup() {
    const current = ref(0)

    provide(KEY, {
      current
    } as FormManagerService)

    return { current }
  }
}
</script>
