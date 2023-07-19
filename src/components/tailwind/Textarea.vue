<template>
  <div>
    <label class="block text-sm font-medium leading-6 text-gray-900">
      {{ label }}
    </label>
    <div class="mt-1">
      <textarea
        :rows="rows || 4"
        class="block w-full rounded-md border-0 p-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
        :value="$props.modelValue"
        :placeholder="placeholder || ''"
        :required="required"
        @input="updateModelValue"
        :name="name"
      />
    </div>
  </div>
</template>

<script lang="ts">
import type { PropType } from 'vue'

export default {
  name: 'TTextarea',
  props: {
    label: String,
    rows: Number,
    modelValue: { type: String as PropType<any> },
    placeholder: String,
    required: Boolean,
    name: String
  },
  emits: { 'update:model-value': (value: string) => value },
  setup(_, { emit }) {
    return {
      updateModelValue(e: Event) {
        const target = e.target as HTMLTextAreaElement
        emit('update:model-value', target.value)
      }
    }
  }
}
</script>
