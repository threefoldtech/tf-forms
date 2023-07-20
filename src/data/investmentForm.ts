import type { FormInput } from '@/components/FormRenderer.vue'

export const investmentFormData: FormInput[][] = [
  [
    {
      label: 'Email',
      placeholder: 'Your email',
      type: 'email',
      value: ''
    },
    {
      label: 'Telephone Number',
      placeholder: 'Your answer',
      value: '',
      class: 'my-5'
    },
    {
      label: 'Referral code',
      subLabel: 'Ask whoever introduced you to get such a code.',
      placeholder: 'Referral code',
      value: ''
    }
  ],
  [
    {
      label: 'I would like to invest and purchase a block of Company slots in the Digital FreeZone',
      subLabel: `
      Imagine the ultimate in sovereignty = a combination of legal, financial and digital privacy.<br /><br />
      Owners of a company in our free zone can own their assets in a safe place, organize their professional life, pay less tax, collaborate with like minded people, no more need for complicated banking transactions.... All is automated through our phone and decentralized safe financial, administrative and collaboration software.<br /><br />
      Such a service normally costs about 20,000 USD per year, the enduser price will be about 50 EUR per month.<br /><br />
      We are looking for investor/resellers who want to purchase these company slots in bulk, depending the volume there will be up to 50% discount. We are working on digital tools which will allow you to re-sell this slot to others at a price of your choice.<br /><br />
      <strong>I am interested to invest in</strong><br /><br />
      `,
      type: 'block'
    },
    {
      type: 'radio',
      name: 'companys',
      radioInputs: [
        { label: '100 company slots', value: '100' },
        { label: '200 company slots', value: '200' },
        { label: '500 company slots', value: '500' },
        { label: '1,000 company slots', value: '1000' },
        { label: '2,000 company slots', value: '2000' },
        { label: '5,000 company slots', value: '5000' },
        { label: 'more than 5,000', value: '>5000' }
      ]
    },
    {
      label: 'I would like to become an Investor in the OurWorld Venture Creator',
      subLabel: `
      There is an open fundraising round of 20m EUR as a convertible loan in the Venture Creator.<br /><br />

      This is a very nice investment interest who allows you to do good for the world and yourself.<br /><br />
      <ul>
        <li>The downside is protected by the value of the shares of all the startups.</li>
        <li>The upside is the value of exciting tech startups. You can chose when to convert.</li>
      </ul><br />
      e.g. you can now invest in the OurWorld venture creator and then convert into the new OurPhone company at preferential right with a discount.<br /><br />
      
      More information see <a target="_blank" href="http://info007.venturecreator.org">http://info007.venturecreator.org</a><br /><br />
      
      I would like to receive more information and might be interested to invest:<br /><br />
      `,
      type: 'block'
    },
    {
      type: 'radio',
      name: 'investment',
      value: '',
      radioInputs: [
        { label: '50k EUR (is minimum)', value: '50k' },
        { label: '100k EUR', value: '100k' },
        { label: '200k EUR', value: '200k' },
        { label: '500k EUR', value: '500k' },
        { label: '1000k EUR', value: '1000k' },
        { label: '2000k EUR', value: '2000k' },
        { label: '5000k EUR', value: '5000k' },
        { label: 'More', value: 'more' }
      ]
    }
  ]
]
