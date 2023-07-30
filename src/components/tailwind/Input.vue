<template>
  <div>
    <label class="block text-sm font-medium leading-6 text-gray-900" v-html="label" />
    <span class="block text-xs leading-6 text-gray-700" v-if="subLabel" v-html="subLabel" />
    <div class="mt-1">
      <input
        :type="type"
        class="block w-full rounded-md border-0 p-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
        :placeholder="placeholder || ''"
        :required="required"
        :value="$props.modelValue"
        @input="updateModelValue"
        :name="$props.name"
        :readonly="readonly || false"
      />
    </div>
  </div>
</template>

<script lang="ts">
import type { PropType } from 'vue'

export default {
  name: 'TInput',
  props: {
    label: String,
    subLabel: String,
    placeholder: String,
    required: Boolean,
    type: String,
    name: String,
    modelValue: { type: String as PropType<any> },
    readonly: Boolean
  },
  emits: { 'update:model-value': (value: any) => value, input: (e: Event) => e },
  setup(_, { emit }) {
    return {
      updateModelValue(e: Event) {
        emit('input', e)
        const target = e.target as HTMLInputElement
        emit('update:model-value', target.value)
      }
    }
  }
}
</script>
