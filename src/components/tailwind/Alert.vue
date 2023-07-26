<template>
  <div
    class="rounded-md bg-blue-50 p-4"
    :class="{
      'bg-blue-50 text-blue-700': type === 'primary',
      'bg-yellow-50 text-yellow-700': type === 'warn',
      'bg-red-50 text-red-700': type === 'error'
    }"
  >
    <p class="text-sm">
      <slot></slot>
    </p>
  </div>
</template>

<script lang="ts">
import type { PropType } from 'vue'

export default {
  name: 'TAlert',
  props: {
    type: {
      type: String as PropType<'primary' | 'warn' | 'error'>,
      default: () => 'primary'
    }
  }
}
</script>
