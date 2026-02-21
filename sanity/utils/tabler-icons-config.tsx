let icons: Array<{}> | undefined = undefined;

export const tablerIconsConfig = {
  configurations: [
    {
      title: 'Tabler Icons',
      provider: 'ti',
      icons: () => icons,
    },
  ],
};

export async function loadIcons() {
  const TablerIcons = await import('@tabler/icons-react');
  icons = Object.entries(TablerIcons).map(([name, Component]) => ({
    name,
    component: () => {
      const IconComponent = TablerIcons[name];
      return <IconComponent style={{ width: '1.5em', height: '1em' }} />;
    },
    tags: [name],
  }));
}
