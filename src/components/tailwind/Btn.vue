<template>
  <button
    :type="type || 'button'"
    class="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
    @click="$emit('click', $event)"
  >
    <slot></slot>
  </button>
</template>

<script lang="ts">
import type { PropType } from 'vue'

export default {
  name: 'TBtn',
  props: {
    type: String as PropType<any>
  }
}
</script>
