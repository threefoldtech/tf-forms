<template>
  <button
    :type="type || 'button'"
    class="rounded-md px-3 py-2 text-sm font-semibold text-white shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2"
    @click="$emit('click', $event)"
    :class="{
      'bg-indigo-600 hover:bg-indigo-500 focus-visible:outline-indigo-600': color === 'primary',
      'bg-red-600 hover:bg-red-500 focus-visible:outline-red-600': color === 'error',
      'bg-green-600 hover:bg-green-500 focus-visible:outline-green-600': color === 'success',
      'opacity-60 pointer-events-none': disabled
    }"
    :disabled="disabled"
  >
    <slot></slot>
  </button>
</template>

<script lang="ts">
import type { PropType } from 'vue'

export default {
  name: 'TBtn',
  props: {
    type: String as PropType<any>,
    color: {
      type: String as PropType<'primary' | 'error' | 'success'>,
      default: () => 'primary'
    },
    disabled: {
      type: Boolean,
      default: () => false
    }
  },
  emits: {
    click: (e: MouseEvent) => e
  }
}
</script>
