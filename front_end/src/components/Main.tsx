import { useEthers } from '@usedapp/core';
import helperConfig from '../helper-config.json';
import { makeStyles } from '@material-ui/core';

const useStyles = makeStyles((theme) => ({
    title: {
        color: theme.palette.common.white,
        textAlign: 'center',
        padding: theme.spacing(4),
    },
}));

export const Main = () => {
    const classes = useStyles();
    const { chainId, error } = useEthers();
    const networkName = chainId ? helperConfig[chainId] : 'dev';

    return <div> I'm Main </div>;
};
